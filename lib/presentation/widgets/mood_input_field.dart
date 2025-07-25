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
      decoration: InputDecoration(
        labelText: 'How are you feeling today?',
        labelStyle: const TextStyle(color: DesignConfig.textFieldColor),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: DesignConfig.addHabbitColor, width: 2),
          borderRadius: DesignConfig.border,
        ),
        enabledBorder:  OutlineInputBorder(
          borderSide: const BorderSide(
              color: DesignConfig.addHabbitColor),
          borderRadius: DesignConfig.border,
        ),
      ),
    );
  }
}
