import 'dart:async';
import 'package:flutter/material.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_image_paths.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/presentation_layer/screens/persist_navbar_view.dart';
import 'package:race_app/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:race_app/translations/locale_keys.g.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImagesPaths.logo,
              width: kScreenWidth * 0.25,
              height: kScreenWidth * 0.25,
              fit: BoxFit.fitHeight,
            ),
            SizedBox(
              height: kScreenWidth * 0.02,
            ),
            const CustomLocalizedTextWidget(
              fontSize: Variables.double23,
              isTranslate: true,
              stringKey: LocaleKeys.splashScreenTitle,
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    Timer(const Duration(milliseconds: Variables.int2500), () {
      navigateUser();
    });
  }

  void navigateUser() async { //suppose to have "await" for token stored in shared preferences if it is already logged in, then navigate the user according to that
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const PersistNavBarView(),
      ),
    );
  }
}
