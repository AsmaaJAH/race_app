
import 'package:flutter/material.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_enum.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/control_layer/managers/themes_manager/text_theme_manager.dart';
import 'package:race_app/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:race_app/presentation_layer/widgets/customized_button.dart';
import 'package:race_app/translations/locale_keys.g.dart';

class TwoOptionsDialogWidget extends StatelessWidget {
  const TwoOptionsDialogWidget({
    super.key,
    this.positiveAction,
    this.dialogTitle,
    this.dialogContent,
    this.positiveButtonText,
    this.negativeButtonText,
    this.negativeButtonColor,
    this.positiveButtonColor,
    this.titleStyle,
    this.dialogContentTextStyle,
    this.isDialogTitleLocalized = true,
    this.isDialogContentLocalized = true,
    this.isNegativeBtnTxtDialogLocalized = true,
    this.isPositiveBtnTxtDialogLocalized = true,
  });

  final bool isDialogTitleLocalized;
  final bool isDialogContentLocalized;
  final bool isPositiveBtnTxtDialogLocalized;
  final bool isNegativeBtnTxtDialogLocalized;
  final Function? positiveAction;
  final String? dialogTitle;
  final String? dialogContent;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final Color? negativeButtonColor;
  final Color? positiveButtonColor;

  final TextStyle? titleStyle;
  final TextStyle? dialogContentTextStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kScreenWidth * 0.67,
      height: kScreenHeight * 0.2001,
      decoration: BoxDecoration(
        color: AppColors.offWhiteBackground,
        borderRadius: BorderRadius.circular(kScreenWidth * 0.038),
      ),
      padding: EdgeInsets.only(
        top: kScreenWidth * 0.049,
        right: Variables.zero,
        left: Variables.zero,
        bottom: Variables.zero,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              height: kScreenHeight * 0.2001 * 0.55, //total height * ratio
              child: Column(
                children: [
                  CustomLocalizedTextWidget(
                      isTranslate: isDialogTitleLocalized,
                      stringKey: dialogTitle != null ? dialogTitle! : "",
                      color: AppColors.primary,
                      style: titleStyle ??
                          TextThemeManager.boldFont(
                              fontSize: Variables.double17),
                      textAlign: TextAlign.center),
                  SizedBox(height: kScreenWidth * 0.015),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Variables.double15),
                    child: CustomLocalizedTextWidget(
                        color: AppColors.primary,
                        isTranslate: isDialogContentLocalized,
                        stringKey: dialogContent != null ? dialogContent! : "",
                        textAlign: TextAlign.center,
                        style: dialogContentTextStyle ??
                            TextThemeManager.regularFont(
                                fontSize: Variables.double13)),
                  ),
                  SizedBox(height: kScreenWidth * 0.025),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: kScreenHeight * 0.2001 * 0.3179,
            right: 0,
            left: 0,
            child: Container(
              color: AppColors.secondary,
              height: Variables.one,
              width: double.infinity,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              height: kScreenHeight * 0.2001 * 0.3179, //total height * 2/3
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomizedButton(
                    isbuttonTextTranslated: isNegativeBtnTxtDialogLocalized,
                    buttonText: negativeButtonText != null
                        ? negativeButtonText!
                        : LocaleKeys.cancelDialog,
                    height: kScreenHeight * 0.05,
                    width: kScreenWidth * 0.3,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    fontSize: Variables.double17,
                    fontWeight: CustomTextWeight.regularFont,
                    backgroundColor: AppColors.offWhiteBackground,
                    textColor: negativeButtonColor ??
                        AppColors.primary,
                  ),
                  const SizedBox(width: Variables.five),
                  Container(
                    color: AppColors.secondary,
                    width: Variables.one,
                    height: double.infinity,
                  ),
                  const SizedBox(width: Variables.five),
                  CustomizedButton(
                    isbuttonTextTranslated: isPositiveBtnTxtDialogLocalized,
                    buttonText: positiveButtonText != null
                        ? positiveButtonText!
                        : LocaleKeys.acceptDialog,
                    height: kScreenHeight * 0.05,
                    width: kScreenWidth * 0.3,
                    onPressed: () {
                      if (positiveAction != null) positiveAction!();
                      Navigator.of(context).pop();
                    },
                    fontSize: 17,
                    fontWeight: CustomTextWeight.regularFont,
                    backgroundColor: AppColors.offWhiteBackground,
                    textColor:
                        positiveButtonColor ?? AppColors.primary,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
