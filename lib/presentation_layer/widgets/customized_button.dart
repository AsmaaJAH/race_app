
import 'package:flutter/material.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_enum.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/control_layer/managers/themes_manager/text_theme_manager.dart';
import 'package:race_app/presentation_layer/widgets/custom_localized_text_widget.dart';

class CustomizedButton extends StatelessWidget {
  const CustomizedButton({
    super.key,
    required this.width,
    this.height,
    this.trailer,
    this.leading,
    this.elevation,
    this.fontSize,
    this.textColor,
    this.borderRadius,
    this.fontWeight,
    this.borderColor,
    this.borderWidth,
    this.backgroundColor,
    this.horizontalSpacing,
    required this.buttonText,
    required this.onPressed,
    this.isbuttonTextTranslated = true,
  });

  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  final double? fontSize;
  final double? borderRadius;
  final double width;
  final double? height;
  final double? elevation;
  final double? horizontalSpacing;
  final double? borderWidth;

  final String buttonText;

  final Widget? trailer;
  final Widget? leading;

  final bool isbuttonTextTranslated;
  final CustomTextWeight? fontWeight;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 44,//in race app, use ratio
      padding:
          EdgeInsets.symmetric(horizontal: horizontalSpacing ?? Variables.zero),
      child: TextButton(
        //--I read that: flat buttons are now just a simple text button in flutter as mentioned in the documentaion:
        style: TextButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.primary,
            elevation: elevation ?? Variables.zero,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(borderRadius ?? Variables.zero),
                side: BorderSide(
                    color: borderColor ?? backgroundColor ?? AppColors.primary,
                    width: borderWidth ?? Variables.one))),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: trailer != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: Variables.five)
            ],
            CustomLocalizedTextWidget(
              isTranslate: isbuttonTextTranslated,
              stringKey: buttonText,
              textAlign: TextAlign.center,
              style: fontWeight != null
                  ? TextThemeManager.fontWeight(
                      fontWeight: fontWeight!,
                      fontSize: fontSize,
                      fontColor: textColor ?? AppColors.white)
                  : TextThemeManager.boldFont(
                      fontColor: textColor ?? AppColors.white,
                      fontSize: fontSize ?? Variables.double18,
                    ),
            ),
            if (trailer != null) ...[
              const SizedBox(
                width: Variables.eight,
              ),
              trailer!
            ] else
              const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}


//------------------As A Flat-Button:
//  CustomizedButton(
//                   //width: kScreenWidth * 0.5,
//                   buttonTitle: "Title",
//                   onPressed: () {}),

//-----------------As An Outlined-Button:
//  CustomizedButton(
//                   titleColor: Colors.red,
//                   backgroundColor: Colors.white,
//                   borderColor: Colors.red,
//                   borderRadius: 20,
//                   width: 70,
//                   buttonTitle: "Title",
//                   onPressed: () {})

//-------------------As A Floating-Action-Button:
  // floatingActionButton: CustomizedButton(
  //             leading: const Icon(
  //               Icons.add,
  //               color: Colors.white,
  //             ),
  //             elevation: 20,
  //             onPressed: () {},
  //             buttonTitle: "button Title",
  //           )

