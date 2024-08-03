import 'package:flutter/material.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_enum.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/presentation_layer/widgets/custom_localized_text_widget.dart';

class SingleLineWidget extends StatelessWidget {
  const SingleLineWidget({super.key, this.icon, required this.text});
  final IconData? icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: Variables.double12,
          color: AppColors.nileBlue,
        ),
        const SizedBox(
          width: Variables.five,
        ),
        SizedBox(
          width: kScreenWidth * 0.27,
          child: CustomLocalizedTextWidget(
            fontSize: Variables.double12,
            stringKey: text,
            maxLines: 2,
            isSoftWrapped: true,
            isThreeDotsInOverFlow: true,
            fontWeight: CustomTextWeight.blackFont,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
