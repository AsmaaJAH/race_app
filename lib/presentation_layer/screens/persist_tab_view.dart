import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/control_layer/managers/bottom_navigator_manager.dart';
import 'package:race_app/presentation_layer/screens/delete_me.dart';
import 'package:race_app/presentation_layer/screens/home_page_screen.dart';

PersistentTabController kController =
    PersistentTabController(initialIndex: Variables.threeInt);

List<Widget> _navScreens() {
  return const [
    DeleteMe(),
    DeleteMe(),
    DeleteMe(),
    HomePageScreen(),
    DeleteMe(),
  ];
}

class PersistTabView extends StatelessWidget {
  const PersistTabView({super.key});

  List<PersistentBottomNavBarItem> get navBarsItems {
    return [
      const BottomNavigatorManager(
        title: "HOME",
        activeIconWidget: Icon(Icons.home_filled),
        inActiveIconWidget: Icon(Icons.home_filled),
      ).navigatorItem,
      const BottomNavigatorManager(
        title: "TRAIN",
        activeIconWidget: Icon(
          FontAwesomeIcons.bullseye,
        ),
        inActiveIconWidget: Icon(
          FontAwesomeIcons.bullseye,
        ),
      ).navigatorItem,
      PersistentBottomNavBarItem(
        icon: Center(
          child: CircleAvatar(
            radius: kScreenHeight * 0.045,
            backgroundColor: AppColors.secondary,
            child: SvgPicture.asset(
              'assets/images/racemate_icon.svg',
              height: kScreenHeight * 0.05,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
      const BottomNavigatorManager(
        title: "EXPLORE",
        activeIconWidget: Icon(FontAwesomeIcons.magnifyingGlassLocation),
        inActiveIconWidget: Icon(FontAwesomeIcons.magnifyingGlassLocation),
      ).navigatorItem,
      const BottomNavigatorManager(
        title: "ME",
        activeIconWidget: Icon(FontAwesomeIcons.chartLine),
        inActiveIconWidget: Icon(FontAwesomeIcons.chartLine),
      ).navigatorItem,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(
          padding: EdgeInsets.only(
              bottom: kScreenHeight * 0.015) // here is the padding
          ),
      child: PersistentTabView(
        context,
        controller: kController,
        screens: _navScreens(),
        items: navBarsItems,
        navBarHeight: kScreenHeight * 0.11,
        backgroundColor: AppColors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardAppears: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(Variables.ten),
          colorBehindNavBar: AppColors.white,
          boxShadow: <BoxShadow>[
            const BoxShadow(
              color: AppColors.primary,
              blurRadius: Variables.five,
            ),
          ],
        ),
        navBarStyle: NavBarStyle.simple,
      ),
    );
  }
}
