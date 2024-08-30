import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/control_layer/managers/bottom_navigator_manager.dart';
import 'package:race_app/data_layer/cubits/visibility_cubit.dart';
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

class PersistNavBarView extends StatelessWidget {
  const PersistNavBarView({super.key});

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
            radius: kScreenHeight * 0.043,
            backgroundColor: AppColors.secondary,
            child: SvgPicture.asset(
              'assets/images/racemate_icon.svg',
              height: kScreenHeight * 0.048,
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
      child: BlocConsumer<VisibilityCubit, VisibilityStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return PersistentTabView(
            context,
            controller: kController,
            screens: _navScreens(),
            padding: const EdgeInsets.only(top: Variables.ten),
            items: navBarsItems,
            isVisible: BlocProvider.of<VisibilityCubit>(context).isVisible,
            navBarHeight: kScreenHeight * 0.08,
            backgroundColor: AppColors.white,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardAppears: true,
            decoration: NavBarDecoration(
              borderRadius: kScreenWidth > 500
                  ? const BorderRadius.vertical(top: Radius.circular(35))
                  : const BorderRadius.vertical(top: Radius.circular(25)),
              colorBehindNavBar: AppColors.white,
              boxShadow: <BoxShadow>[
                const BoxShadow(
                  color: Color.fromARGB(140, 0, 10, 53),
                  blurRadius: Variables.five,
                ),
              ],
            ),
            navBarStyle: NavBarStyle.simple,
          );
        },
      ),
    );
  }
}
