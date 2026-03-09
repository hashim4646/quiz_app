import 'dart:async';
import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../data/questions_data.dart';

enum QuizStatus { idle, active, finished }

class QuizProvider extends ChangeNotifier {
  // ─── State ───────────────────────────────────────────────
  List<QuestionModel> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  int _selectedAnswer = -1;
  bool _isAnswered = false;
  int _timeLeft = 30;
  String _selectedCategory = '';
  QuizStatus _status = QuizStatus.idle;
  final List<int> _userAnswers = [];
  Timer? _timer;

  // ─── Getters ──────────────────────────────────────────────
  List<QuestionModel> get questions => _questions;
  int get currentIndex => _currentIndex;
  int get score => _score;
  int get selectedAnswer => _selectedAnswer;
  bool get isAnswered => _isAnswered;
  int get timeLeft => _timeLeft;
  String get selectedCategory => _selectedCategory;
  QuizStatus get status => _status;
  List<int> get userAnswers => List.unmodifiable(_userAnswers);

  QuestionModel get currentQuestion => _questions[_currentIndex];
  int get totalQuestions => _questions.length;
  bool get isLastQuestion => _currentIndex >= _questions.length - 1;
  int get correctAnswersCount =>
      _userAnswers.where((a) => a != -1).
          toList()
          .asMap()
          .entries
          .where((e) => e.value == _questions[e.key].correctIndex)
          .length;
  int get wrongAnswersCount => _questions.length - correctAnswersCount;
  double get scorePercent =>
      _questions.isEmpty ? 0 : (correctAnswersCount / _questions.length);

  String get grade {
    final pct = scorePercent;
    if (pct >= 0.90) return 'S';
    if (pct >= 0.80) return 'A';
    if (pct >= 0.70) return 'B';
    if (pct >= 0.60) return 'C';
    return 'D';
  }

  String get gradeMessage {
    switch (grade) {
      case 'S':
        return 'Outstanding! 🏆';
      case 'A':
        return 'Excellent Work! 🌟';
      case 'B':
        return 'Great Job! 👍';
      case 'C':
        return 'Keep Going! 💪';
      default:
        return 'Keep Practicing! 📚';
    }
  }

  Color gradeColor(BuildContext context) {
    switch (grade) {
      case 'S':
        return const Color(0xFFFFD700);
      case 'A':
        return const Color(0xFF00C896);
      case 'B':
        return const Color(0xFF6C63FF);
      case 'C':
        return const Color(0xFFFFB800);
      default:
        return const Color(0xFFFF4560);
    }
  }

  // ─── Start Quiz ───────────────────────────────────────────
  void startQuiz(String category) {
    _selectedCategory = category;
    _questions = QuestionsData.getQuestions(category);
    _questions.shuffle();
    _currentIndex = 0;
    _score = 0;
    _selectedAnswer = -1;
    _isAnswered = false;
    _userAnswers.clear();
    _status = QuizStatus.active;
    _startTimer();
    notifyListeners();
  }

  // ─── Timer ────────────────────────────────────────────────
  void _startTimer() {
    _timeLeft = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        _timeLeft--;
        notifyListeners();
      } else {
        _onTimerExpired();
      }
    });
  }

  void _onTimerExpired() {
    _timer?.cancel();
    if (!_isAnswered) {
      _selectedAnswer = -1;
      _isAnswered = true;
      _userAnswers.add(-1); // timed out = -1
      notifyListeners();
    }
  }

  // ─── Select Answer ────────────────────────────────────────
  void selectAnswer(int index) {
    if (_isAnswered) return;
    _timer?.cancel();
    _selectedAnswer = index;
    _isAnswered = true;
    _userAnswers.add(index);
    if (index == currentQuestion.correctIndex) {
      _score += 10;
    }
    notifyListeners();
  }

  // ─── Next Question ────────────────────────────────────────
  void nextQuestion() {
    if (isLastQuestion) {
      _status = QuizStatus.finished;
      _timer?.cancel();
      notifyListeners();
      return;
    }
    _currentIndex++;
    _selectedAnswer = -1;
    _isAnswered = false;
    _startTimer();
    notifyListeners();
  }

  // ─── Reset ────────────────────────────────────────────────
  void resetQuiz() {
    _timer?.cancel();
    _questions = [];
    _currentIndex = 0;
    _score = 0;
    _selectedAnswer = -1;
    _isAnswered = false;
    _timeLeft = 30;
    _selectedCategory = '';
    _status = QuizStatus.idle;
    _userAnswers.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
