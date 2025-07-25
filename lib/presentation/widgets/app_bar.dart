import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class AppBarDesign extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarDesign({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // ✅ مهم برای Scaffold

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: DesignConfig.backgroundColor,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: DesignConfig.semiBold,
          color: DesignConfig.textColor,
          fontSize: DesignConfig.appBarTextSize,
        ),
      ),
    );
  }
}
