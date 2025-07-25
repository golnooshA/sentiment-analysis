import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class CheckboxTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CheckboxTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: value ? DesignConfig.primaryColor : Colors.white,
          borderRadius: DesignConfig.border,
          border: Border.all(
            color: value ? DesignConfig.backgroundColor : DesignConfig.borderColor,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: value ? DesignConfig.backgroundColor : DesignConfig.textColor,
                  fontSize: DesignConfig.textSize,
                  fontWeight: DesignConfig.semiBold,
                ),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: value ? Colors.white : Colors.transparent,
                shape: BoxShape.circle,
                border: value
                    ? null
                    : Border.all(color: DesignConfig.borderColor, width: 1.5),
              ),
              child: value
                  ? const Icon(Icons.check, size: 16, color: DesignConfig.primaryColor)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
