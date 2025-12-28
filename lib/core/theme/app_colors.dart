import 'package:flutter/cupertino.dart';

abstract class AppColors {
  // Core
  Color get primary;
  Color get background;
  Color get surface; // Cards, Modals
  Color get text;
  Color get subText;
  Color get border;
  Color get shadow;
  Color get icon;

  // Board Specific
  Color get columnBackground;
  Color get columnHeader;
  Color get cardPlaceholderText;
  
  // Inputs & Buttons
  Color get inputBackground;
  Color get buttonText;
  Color get buttonBackground;

  // Icons
  IconData get themeToggleIcon;
}

class LightAppColors implements AppColors {
  @override
  Color get primary => CupertinoColors.systemBlue;
  @override
  Color get background => CupertinoColors.systemGroupedBackground;
  @override
  Color get surface => CupertinoColors.white;
  @override
  Color get text => CupertinoColors.black;
  @override
  Color get subText => CupertinoColors.systemGrey;
  @override
  Color get border => CupertinoColors.systemGrey5;
  @override
  Color get shadow => CupertinoColors.black.withOpacity(0.05);
  @override
  Color get icon => CupertinoColors.black;

  @override
  Color get columnBackground => CupertinoColors.white;
  @override
  Color get columnHeader => CupertinoColors.black;
  @override
  Color get cardPlaceholderText => CupertinoColors.systemGrey3;

  @override
  Color get inputBackground => CupertinoColors.white;
  @override
  Color get buttonText => CupertinoColors.white;
  @override
  Color get buttonBackground => CupertinoColors.activeBlue;

  @override
  IconData get themeToggleIcon => CupertinoIcons.moon_fill;
}

class DarkAppColors implements AppColors {
  @override
  Color get primary => CupertinoColors.systemBlue;
  @override
  Color get background => CupertinoColors.black;
  @override
  Color get surface => CupertinoColors.systemGrey6.darkColor;
  @override
  Color get text => CupertinoColors.white;
  @override
  Color get subText => CupertinoColors.systemGrey;
  @override
  Color get border => CupertinoColors.white.withOpacity(0.1);
  @override
  Color get shadow => CupertinoColors.black.withOpacity(0.2);
  @override
  Color get icon => CupertinoColors.white;

  @override
  Color get columnBackground => CupertinoColors.systemGrey6.darkColor;
  @override
  Color get columnHeader => CupertinoColors.white;
  @override
  Color get cardPlaceholderText => CupertinoColors.systemGrey;

  @override
  Color get inputBackground => CupertinoColors.systemGrey6.darkColor;
  @override
  Color get buttonText => CupertinoColors.white;
  @override
  Color get buttonBackground => CupertinoColors.activeBlue;

  @override
  IconData get themeToggleIcon => CupertinoIcons.sun_max_fill;
}
