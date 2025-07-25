import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;

  const InputField({
    super.key,
    required this.controller,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              cursorColor: DesignConfig.secondColor,
              style: const TextStyle(
                color: DesignConfig.textColor,
                fontSize: DesignConfig.textSize,
              ),
              decoration: InputDecoration(
                labelText: 'Enter a habit',
                labelStyle: const TextStyle(
                  color: DesignConfig.textFieldColor,
                  fontWeight: DesignConfig.semiBold,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: DesignConfig.secondColor,
                    width: 2,
                  ),
                  borderRadius: DesignConfig.border,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: DesignConfig.secondColor,
                  ),
                  borderRadius: DesignConfig.border,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onAdd,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: DesignConfig.secondColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: DesignConfig.iconColor,
                size: DesignConfig.iconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
