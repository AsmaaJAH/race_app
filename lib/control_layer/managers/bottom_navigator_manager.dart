import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/control_layer/managers/themes_manager/text_theme_manager.dart';


class BottomNavigatorManager {
  const BottomNavigatorManager({
    required this.activeIconWidget,
    this.inActiveIconWidget,
    required this.title,
    this.contentPadding,
    this.iconSize,
    this.onPressed,
  });
  final Widget activeIconWidget;
  final Widget? inActiveIconWidget;
  final String title;
  final double? iconSize;
  final double? contentPadding;
  final dynamic Function(BuildContext?)? onPressed;

  PersistentBottomNavBarItem get navigatorItem {
    return PersistentBottomNavBarItem(
      
      contentPadding: contentPadding ?? Variables.five,
      icon: activeIconWidget,
      iconSize: iconSize ?? kScreenWidth * 0.085,
      inactiveIcon: inActiveIconWidget,
      title: title.tr(),
      onPressed: onPressed,
      activeColorPrimary: AppColors.primary,
      inactiveColorPrimary: AppColors.lightBlue,
      textStyle: TextThemeManager.regularFont(
        fontSize: Variables.ten,
      ),
    );
  }
}
