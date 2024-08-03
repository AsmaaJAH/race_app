import 'package:flutter/material.dart';
import 'package:race_app/constants/app_image_paths.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/presentation_layer/widgets/customized_appbar.dart';
import 'package:race_app/presentation_layer/widgets/races_body_widgets.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 2, //start: 0,1,2
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const CustomizedAppBar(),
          ],
          body: TabBarView(
            children: [
              Center(
                child: Image.asset(
                  AppImagesPaths.logo,
                  width: kScreenWidth * 0.25,
                  height: kScreenWidth * 0.25,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Center(
                child: Image.asset(
                  AppImagesPaths.logo,
                  width: kScreenWidth * 0.25,
                  height: kScreenWidth * 0.25,
                  fit: BoxFit.fitHeight,
                ),
              ),
              const RacesBodyWidgets()
            ],
          ),
        ),
      ),
    );
  }
}
