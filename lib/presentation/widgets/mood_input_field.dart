import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class MoodInputField extends StatelessWidget {
  final TextEditingController controller;

  const MoodInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 3,
      decoration: const InputDecoration(
        labelText: 'How are you feeling today?',
        labelStyle: TextStyle(color: DesignConfig.textFieldColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DesignConfig.textFieldColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DesignConfig.textFieldColor, width: 2),
        ),
      ),
    );
  }
}
