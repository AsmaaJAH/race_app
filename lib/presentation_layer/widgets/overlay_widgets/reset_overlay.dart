import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_enum.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/control_layer/managers/themes_manager/text_theme_manager.dart';
import 'package:race_app/data_layer/cubits/races_cubit.dart';
import 'package:race_app/presentation_layer/widgets/customized_button.dart';

class ResetOverlay extends StatelessWidget {
  const ResetOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Clear filters?',
                style: TextThemeManager.boldFont(fontSize: 22),
              ),
            ),
            CustomizedButton(
              borderRadius: Variables.five,
              width: kScreenWidth * 0.9,
              buttonText: 'YES, CLEAR FILTERS',
              textColor: AppColors.primary,
              fontSize: 14,
              fontWeight: CustomTextWeight.boldFont,
              backgroundColor: AppColors.secondary,
              height: kScreenHeight * 0.05,
              onPressed: () {
                BlocProvider.of<RacesCubit>(context).reset();
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(
              height: 12,
            ),
            CustomizedButton(
              borderRadius: Variables.five,
              width: kScreenWidth * 0.9,
              buttonText: 'CANCEL',
              textColor: AppColors.primary,
              fontSize: 14,
              fontWeight: CustomTextWeight.boldFont,
              backgroundColor: AppColors.white,
              borderColor: AppColors.primary,
              height: kScreenHeight * 0.05,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
  }
}
