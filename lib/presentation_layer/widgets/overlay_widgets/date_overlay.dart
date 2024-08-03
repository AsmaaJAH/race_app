import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_enum.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/control_layer/functions/home_assist_functions.dart';
import 'package:race_app/control_layer/managers/themes_manager/text_theme_manager.dart';
import 'package:race_app/data_layer/cubits/races_cubit.dart';
import 'package:race_app/presentation_layer/widgets/customized_button.dart';
import 'package:race_app/presentation_layer/widgets/overlay_widgets/overlay_title.dart';

class DateOverlay extends StatefulWidget {
  const DateOverlay({super.key, required this.index});
  final int index;
  @override
  State<DateOverlay> createState() => _DateOverlayState();
}

class _DateOverlayState extends State<DateOverlay> {
  DateTime initalDate = DateTime.now();
  DateTime finalDate = DateTime.now();

  void _onPressDone(context) {
    if (BlocProvider.of<RacesCubit>(context).filters[widget.index].isEnabled ==
        false) {
      BlocProvider.of<RacesCubit>(context).filters[widget.index].isEnabled =
          true;
      BlocProvider.of<RacesCubit>(context).numberOfFilters += 1;
    }
    BlocProvider.of<RacesCubit>(context).filterByDate(initalDate, finalDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: OverlayTitle(
              title: 'RACE DATE',
              onPressed: () {
                const HomeAssistFunctions()
                    .onPressResetSingleFilter(context, widget.index);
              },
            ),
          ),
          CustomDateButton(
            date: initalDate,
            title: 'From',
            onTap: () async {
              DateTime? picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2025),
                  initialDate: DateTime.now());
              if (picked != null) {
                setState(() {
                  initalDate = picked;
                });
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CustomDateButton(
            date: finalDate,
            title: 'To',
            onTap: () async {
              DateTime? picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                  initialDate: DateTime.now());
              if (picked != null) {
                setState(() {
                  finalDate = picked;
                });
              }
            },
          ),
          const SizedBox(
            height: 26,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
            child: CustomizedButton(
              borderRadius: Variables.five,
              width: kScreenWidth * 0.9,
              buttonText: 'DONE',
              textColor: AppColors.primary,
              fontSize: 14,
              fontWeight: CustomTextWeight.boldFont,
              backgroundColor: AppColors.secondary,
              height: kScreenHeight * 0.05,
              onPressed: () {
                _onPressDone(context);
              },
            ),
          )
        ],
      ),
    );
  }
}

class CustomDateButton extends StatelessWidget {
  const CustomDateButton(
      {super.key, required this.date, required this.title, this.onTap});
  final DateTime date;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextThemeManager.mediumFont()
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 6,
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.secondary)),
              child: ListTile(
                minLeadingWidth: 0,
                leading: const Icon(
                  FontAwesomeIcons.calendarDays,
                  color: AppColors.primary,
                  size: 20,
                ),
                title: Text(
                  DateFormat.yMMMMEEEEd().format(date),
                  style: TextThemeManager.boldFont(
                      fontColor: const Color(0xff1C325F)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
