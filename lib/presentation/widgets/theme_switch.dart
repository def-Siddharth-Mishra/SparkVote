import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode =
        themeProvider.themeMode == ThemeMode.dark ||
        (themeProvider.themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    return IconButton(
      icon: Icon(
        isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
      ),
      onPressed: () {
        themeProvider.toggleTheme(!isDarkMode);
      },
    );
  }
}
