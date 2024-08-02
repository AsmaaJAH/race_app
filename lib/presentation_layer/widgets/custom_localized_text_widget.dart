import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_enum.dart';
import 'package:race_app/constants/app_fonts.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/control_layer/managers/themes_manager/text_theme_manager.dart';



class CustomLocalizedTextWidget extends StatelessWidget {
  const CustomLocalizedTextWidget({
    super.key,
    this.args,
    this.style,
    this.overflow,
    this.maxLines,
    this.textDirection,
    required this.stringKey,
    this.fontSize = 14,
    this.isTranslate = true,
    this.isSoftWrapped = true,
    this.isThreeDotsInOverFlow =
        false, //it make no sense to me to set it to true if the "isTranslate" is also true..
    this.fontFamily = AppFonts.fontFamily,
    this.color = AppColors.primary,
    this.textAlign = TextAlign.start,
    this.fontWeight = CustomTextWeight.regularFont,

  });

  final Color color;

  final int? maxLines;

  final double fontSize;

  final bool isSoftWrapped;
  final bool isTranslate;
  final bool isThreeDotsInOverFlow;

  final String fontFamily;
  final String stringKey;

  final TextStyle? style;
  final TextAlign textAlign;
  final List<String>? args;

  final ui.TextDirection? textDirection;
  final CustomTextWeight fontWeight;
  final TextOverflow? overflow;

  Text textWidget(BuildContext context) {
    final direction =
        Localizations.localeOf(context).languageCode == Variables.arLangCode
            ? ui.TextDirection.rtl
            : ui.TextDirection.ltr;
    return Text(stringKey,
        textAlign: textAlign,
        overflow: isThreeDotsInOverFlow ? TextOverflow.ellipsis : overflow,
        maxLines: maxLines,
        textDirection: textDirection ?? direction,
        softWrap: isSoftWrapped,
        style: style ??
            TextThemeManager.fontWeight(
              fontSize: fontSize,
              fontColor: color,
              fontWeight: fontWeight,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return isTranslate
        ? textWidget(context).tr(args: args)
        : textWidget(context);
  }
}
