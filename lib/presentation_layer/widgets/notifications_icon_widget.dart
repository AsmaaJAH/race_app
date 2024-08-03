import 'package:flutter/material.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/constants/variables.dart';

class NotificationsIconWidget extends StatelessWidget {
  const NotificationsIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      },
      child: Stack(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              size: kScreenWidth * 0.09,
              color: AppColors.secondary,
            ),
            onPressed: () {
            },
          ),
           Positioned(
                  left: kScreenWidth * 0.065,
                  top: kScreenHeight * 0.017,
                  child: Container(
                    padding: const EdgeInsets.all(Variables.double0_5),
                    decoration: BoxDecoration(
                      color: AppColors.redNotification,
                      borderRadius: BorderRadius.circular(Variables.ten),
                    ),
                    constraints: BoxConstraints(
                      minWidth: kScreenWidth * 0.04,
                      minHeight: kScreenWidth * 0.04,
                    ),
                    
                  ),
                )
              
        ],
      ),
    );
  }
}
