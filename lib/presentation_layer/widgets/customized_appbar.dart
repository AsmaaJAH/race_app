import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_image_paths.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/control_layer/managers/themes_manager/text_theme_manager.dart';
import 'package:race_app/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:race_app/presentation_layer/widgets/notifications_icon_widget.dart';

class CustomizedAppBar extends StatelessWidget {
  const CustomizedAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      stretch: true,
      pinned: true,
      floating: true,
      // snap: true,
      elevation: Variables.ten,
      backgroundColor: AppColors.primary,
      bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelStyle: TextThemeManager.blackFont(
            fontSize: Variables.double12,
            fontColor: AppColors.lightBlue,
          ),
          labelStyle: TextThemeManager.blackFont(
              fontSize: Variables.double18, fontColor: AppColors.white),
          labelPadding: const EdgeInsets.symmetric(vertical: 8),
          indicatorColor: AppColors.secondary,
          indicatorWeight: Variables.seven,
          tabs: [
            CustomLocalizedTextWidget(
              stringKey: 'RUN',
              style: TextThemeManager.blackFont(
                fontSize: Variables.double16,
              ),
            ),
            CustomLocalizedTextWidget(
              stringKey: 'COMMUNITY',
              style: TextThemeManager.blackFont(
                fontSize: Variables.double16,
              ),
            ),
            CustomLocalizedTextWidget(
              stringKey: 'RACES',
              style: TextThemeManager.blackFont(
                fontSize: Variables.double16,
              ),
            ),
          ]),
      flexibleSpace: FlexibleSpaceBar(
      
        background: Container(
          padding: EdgeInsets.only(
              bottom: kScreenHeight * 0.02),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/flexible_space_bar.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(AppImagesPaths.appBarLeading),
                  Row(
                    children: [
                      const NotificationsIconWidget(),
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset('assets/images/account.svg')),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
