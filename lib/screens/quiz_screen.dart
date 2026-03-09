import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quiz_app/screens/result_screen.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/answer_option_card.dart';
import '../widgets/timer_widget.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _questionAnim;
  int _previousIndex = -1;
  bool _isNavigating = false;

  void _onQuizStateChanged() {
    final provider = context.read<QuizProvider>();
    if (provider.status == QuizStatus.finished && !_isNavigating) {
      _isNavigating = true;
      provider.removeListener(_onQuizStateChanged); // Stop listening to avoid duplicates
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/result');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _questionAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..forward();
    
    // Add safe listener for navigation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<QuizProvider>().addListener(_onQuizStateChanged);
      }
    });
  }

  @override
  void dispose() {
    _questionAnim.dispose();
    final provider = context.read<QuizProvider>();
    provider.removeListener(_onQuizStateChanged);
    super.dispose();
  }

  void _animateNextQuestion() {
    _questionAnim.reset();
    _questionAnim.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, child) {

        // Animate when index changes
        if (_previousIndex != provider.currentIndex) {
          _previousIndex = provider.currentIndex;
          WidgetsBinding.instance.addPostFrameCallback((_) => _animateNextQuestion());
        }

        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0D0D1A), Color(0xFF1A0A3B)],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildTopBar(context, provider),
                    const SizedBox(height: 20),
                    _buildProgressBar(provider),
                    const SizedBox(height: 28),
                    _buildCategoryChip(provider),
                    const SizedBox(height: 16),
                    _buildQuestionCard(provider),
                    const SizedBox(height: 24),
                    _buildAnswerOptions(provider),
                    const Spacer(),
                    if (provider.isAnswered) _buildNextButton(context, provider),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopBar(BuildContext context, QuizProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            provider.resetQuiz();
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.primaryColor.withAlpha(60)),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: AppTheme.textPrimary, size: 18),
          ),
        ),
        Column(
          children: [
            Text(
              '${provider.currentIndex + 1} / ${provider.totalQuestions}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            Text(
              'Question',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
        TimerWidget(timeLeft: provider.timeLeft),
      ],
    );
  }

  Widget _buildProgressBar(QuizProvider provider) {
    final progress =
        (provider.currentIndex + 1) / provider.totalQuestions;
    return Column(
      children: [
        LinearPercentIndicator(
          percent: progress,
          lineHeight: 8,
          barRadius: const Radius.circular(8),
          progressColor: AppTheme.primaryColor,
          backgroundColor: AppTheme.cardColor,
          padding: EdgeInsets.zero,
          animation: true,
          animateFromLastPercent: true,
          animationDuration: 400,
        ),
      ],
    );
  }

  Widget _buildCategoryChip(QuizProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withAlpha(30),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryColor.withAlpha(80)),
      ),
      child: Text(
        provider.selectedCategory,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildQuestionCard(QuizProvider provider) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.3, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _questionAnim,
        curve: Curves.easeOutCubic,
      )),
      child: FadeTransition(
        opacity: _questionAnim,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppTheme.primaryColor.withAlpha(40)),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withAlpha(20),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Text(
            provider.currentQuestion.question,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 19,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerOptions(QuizProvider provider) {
    return Column(
      children: List.generate(
        provider.currentQuestion.options.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: FadeInUp(
            delay: Duration(milliseconds: index * 80),
            duration: const Duration(milliseconds: 350),
            child: AnswerOptionCard(
              option: provider.currentQuestion.options[index],
              index: index,
              selectedIndex: provider.selectedAnswer,
              correctIndex: provider.currentQuestion.correctIndex,
              isAnswered: provider.isAnswered,
              onTap: () => provider.selectAnswer(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context, QuizProvider provider) {
    return FadeInUp(
      duration: const Duration(milliseconds: 300),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => provider.nextQuestion(),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            elevation: 8,
            shadowColor: AppTheme.primaryColor.withAlpha(100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                provider.isLastQuestion ? 'See Results' : 'Next Question',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                provider.isLastQuestion
                    ? Icons.emoji_events_rounded
                    : Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
