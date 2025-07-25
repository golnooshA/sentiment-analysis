import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class MoodSaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const MoodSaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: DesignConfig.saveButtonColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text(
        'Save Mood',
        style: TextStyle(color: DesignConfig.textColor, fontWeight: FontWeight.w500),
      ),
    );
  }
}
