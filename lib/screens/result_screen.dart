import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuizProvider>();
    final percent = provider.scorePercent;
    final gradeColor = provider.gradeColor(context);

    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: FadeInUp(
          delay: const Duration(milliseconds: 700),
          child: _buildButtons(context, provider),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0D0D1A), Color(0xFF1A0A3B)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
            child: Column(
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: _buildHeader(),
                ),
                const SizedBox(height: 20),
                ZoomIn(
                  duration: const Duration(milliseconds: 700),
                  child: _buildScoreCircle(percent, gradeColor, provider),
                ),
                const SizedBox(height: 10),
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: Text(
                    provider.gradeMessage,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: gradeColor,
                      shadows: [Shadow(color: gradeColor, blurRadius: 15)],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeInUp(
                  delay: const Duration(milliseconds: 500),
                  child: _buildStatsRow(provider),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  delay: const Duration(milliseconds: 600),
                  child: _buildReviewSection(provider),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        BounceInDown(
          duration: const Duration(milliseconds: 800),
          child: const Text('🏆', style: TextStyle(fontSize: 52)),
        ),
        const SizedBox(height: 8),
        const Text(
          'Quiz Complete!',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildScoreCircle(
      double percent, Color gradeColor, QuizProvider provider) {
    return CircularPercentIndicator(
      radius: 85,
      lineWidth: 11,
      percent: percent,
      backgroundColor: AppTheme.cardColor,
      progressColor: gradeColor,
      circularStrokeCap: CircularStrokeCap.round,
      animation: true,
      animationDuration: 1200,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${(percent * 100).toInt()}%',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: gradeColor.withAlpha(30),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: gradeColor.withAlpha(80)),
            ),
            child: Text(
              'Grade ${provider.grade}',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: gradeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(QuizProvider provider) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: '✅',
            value: '${provider.correctAnswersCount}',
            label: 'Correct',
            color: AppTheme.correctColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: '❌',
            value: '${provider.wrongAnswersCount}',
            label: 'Wrong',
            color: AppTheme.wrongColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: '⭐',
            value: '${provider.score}',
            label: 'Points',
            color: AppTheme.warningColor,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewSection(QuizProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryColor.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Answer Review',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              provider.totalQuestions,
              (i) {
                final userAns = provider.userAnswers[i];
                final correctAns = provider.questions[i].correctIndex;
                final isCorrect = userAns == correctAns;
                final isSkipped = userAns == -1;
                final cellColor = isSkipped
                    ? AppTheme.textHint
                    : isCorrect
                        ? AppTheme.correctColor
                        : AppTheme.wrongColor;
                return Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: cellColor.withAlpha(40),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: cellColor),
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: cellColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context, QuizProvider provider) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Restart same category quiz, navigate to quiz route
              provider.startQuiz(provider.selectedCategory);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/quiz',
                (route) => route.settings.name == '/',
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              elevation: 8,
              shadowColor: AppTheme.primaryColor.withAlpha(100),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.refresh_rounded, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Play Again',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              provider.resetQuiz();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.textPrimary,
              side: BorderSide(color: AppTheme.primaryColor.withAlpha(120)),
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home_rounded),
                SizedBox(width: 8),
                Text(
                  'Go Home',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
