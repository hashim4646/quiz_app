import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AnswerOptionCard extends StatefulWidget {
  final String option;
  final int index;
  final int selectedIndex;
  final int correctIndex;
  final bool isAnswered;
  final VoidCallback onTap;

  const AnswerOptionCard({
    super.key,
    required this.option,
    required this.index,
    required this.selectedIndex,
    required this.correctIndex,
    required this.isAnswered,
    required this.onTap,
  });

  @override
  State<AnswerOptionCard> createState() => _AnswerOptionCardState();
}

class _AnswerOptionCardState extends State<AnswerOptionCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;

  // Labels for answer options
  static const List<String> _labels = ['A', 'B', 'C', 'D'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.96,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnim = _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _cardColor {
    if (!widget.isAnswered) {
      return widget.selectedIndex == widget.index
          ? AppTheme.primaryColor.withAlpha(40)
          : AppTheme.cardColor;
    }
    // After answering:
    if (widget.index == widget.correctIndex) return AppTheme.correctColor.withAlpha(35);
    if (widget.index == widget.selectedIndex) return AppTheme.wrongColor.withAlpha(35);
    return AppTheme.cardColor.withAlpha(80);
  }

  Color get _borderColor {
    if (!widget.isAnswered) {
      return widget.selectedIndex == widget.index
          ? AppTheme.primaryColor
          : AppTheme.primaryColor.withAlpha(40);
    }
    if (widget.index == widget.correctIndex) return AppTheme.correctColor;
    if (widget.index == widget.selectedIndex) return AppTheme.wrongColor;
    return AppTheme.primaryColor.withAlpha(20);
  }

  Color get _labelBgColor {
    if (!widget.isAnswered) {
      return widget.selectedIndex == widget.index
          ? AppTheme.primaryColor
          : AppTheme.surfaceColor;
    }
    if (widget.index == widget.correctIndex) return AppTheme.correctColor;
    if (widget.index == widget.selectedIndex) return AppTheme.wrongColor;
    return AppTheme.surfaceColor;
  }

  Color get _textColor {
    if (!widget.isAnswered) return AppTheme.textPrimary;
    if (widget.index == widget.correctIndex) return AppTheme.correctColor;
    if (widget.index == widget.selectedIndex) return AppTheme.wrongColor;
    return AppTheme.textHint;
  }

  Widget _buildTrailingIcon() {
    if (!widget.isAnswered) return const SizedBox.shrink();
    if (widget.index == widget.correctIndex) {
      return const Icon(Icons.check_circle_rounded,
          color: AppTheme.correctColor, size: 22);
    }
    if (widget.index == widget.selectedIndex) {
      return const Icon(Icons.cancel_rounded,
          color: AppTheme.wrongColor, size: 22);
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (!widget.isAnswered) _controller.reverse();
      },
      onTapUp: (_) {
        _controller.forward();
        if (!widget.isAnswered) widget.onTap();
      },
      onTapCancel: () => _controller.forward(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: _cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _borderColor, width: 1.5),
            boxShadow: widget.isAnswered && widget.index == widget.correctIndex
                ? [
                    BoxShadow(
                      color: AppTheme.correctColor.withAlpha(50),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _labelBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    _labels[widget.index],
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  widget.option,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _textColor,
                  ),
                ),
              ),
              _buildTrailingIcon(),
            ],
          ),
        ),
      ),
    );
  }
}
