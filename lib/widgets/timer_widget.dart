import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TimerWidget extends StatelessWidget {
  final int timeLeft;
  static const int _maxTime = 30;

  const TimerWidget({super.key, required this.timeLeft});

  Color get _timerColor {
    if (timeLeft > 20) return AppTheme.correctColor;
    if (timeLeft > 10) return AppTheme.warningColor;
    return AppTheme.wrongColor;
  }

  @override
  Widget build(BuildContext context) {
    final fraction = timeLeft / _maxTime;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _timerColor.withAlpha(20),
        border: Border.all(color: _timerColor, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: _timerColor.withAlpha(timeLeft <= 10 ? 80 : 30),
            blurRadius: 12,
            spreadRadius: timeLeft <= 10 ? 4 : 0,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              value: fraction,
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(_timerColor),
              backgroundColor: _timerColor.withAlpha(30),
            ),
          ),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: timeLeft <= 10 ? 16 : 14,
              fontWeight: FontWeight.w800,
              color: _timerColor,
            ),
            child: Text('$timeLeft'),
          ),
        ],
      ),
    );
  }
}
