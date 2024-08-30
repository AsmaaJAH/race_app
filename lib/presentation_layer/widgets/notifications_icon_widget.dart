import 'package:flutter/material.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_image_paths.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/constants/variables.dart';

class NotificationsIconWidget extends StatelessWidget {
  const NotificationsIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (kScreenWidth > 550) {
      return Image.asset(AppImagesPaths.notifications);
        // Stack(
        //   children: <Widget>[
          // Positioned(
          //   right:kScreenWidth>500?kScreenWidth * 0.05: kScreenWidth * 0.043,
          //   top: kScreenWidth>500?kScreenHeight * 0.02:kScreenHeight * 0.019,
          //   child:CircleAvatar(
          //     backgroundColor:AppColors.redNotification ,
          //     minRadius:kScreenWidth>500?null: Variables.five,
          //     maxRadius: kScreenWidth>500?Variables.seven,
          //   ),
            // ])
    } else {
      return InkWell(
        onTap: () {},
        child: Stack(
          children: <Widget>[
            Positioned(
              child: IconButton(
                icon: const Icon(
                  Icons.notifications,

                  color: AppColors.secondary,
                ),
                onPressed: () {},
              ),
            ),
            Positioned(
              right: kScreenWidth * 0.043,
              top: kScreenHeight * 0.019,
              child: const CircleAvatar(
                backgroundColor: AppColors.redNotification,
                minRadius: Variables.five,
              ),
            )
          ],
        ),
      );
    }
  }
}

            //  Container(
            //   //padding: const EdgeInsets.all(Variables.double0_5),
            //   decoration: BoxDecoration(
            //     color: AppColors.redNotification,
            //     borderRadius: BorderRadius.circular(kScreenWidth * 0.01),
            //   ),
            //   constraints: BoxConstraints(
            //     minWidth: kScreenWidth * 0.025,
            //     minHeight: kScreenWidth * 0.025,
            //   ),
            // ),

