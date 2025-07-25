import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class EvaluateButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final Size size;
  final BorderRadius? borderRadius;

  const EvaluateButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.onPressed,
    this.size = const Size(double.infinity, 60),
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: size,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: DesignConfig.semiBold,
          fontSize: DesignConfig.buttonTextSize,
          color: DesignConfig.textColor,
          inherit: true,
        ),
      ),
    );
  }
}
