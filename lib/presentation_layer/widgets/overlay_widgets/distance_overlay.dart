import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_enum.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/control_layer/functions/home_assist_functions.dart';
import 'package:race_app/data_layer/cubits/races_cubit.dart';
import 'package:race_app/data_layer/cubits/visibility_cubit.dart';
import 'package:race_app/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:race_app/presentation_layer/widgets/customized_button.dart';
import 'package:race_app/presentation_layer/widgets/overlay_widgets/overlay_title.dart';

class DistanceOverlay extends StatefulWidget {
  const DistanceOverlay({super.key, required this.index});
  final int index;
  @override
  State<DistanceOverlay> createState() => _DistanceOverlayState();
}

class _DistanceOverlayState extends State<DistanceOverlay> {
  late RangeValues distanceRange;
  @override
  void initState() {
    super.initState();
    distanceRange = BlocProvider.of<RacesCubit>(context).distanceRange;
  }

  void _onPressDone(context) {
    BlocProvider.of<VisibilityCubit>(context).turnOnNavBarVisibility();
    final races = BlocProvider.of<RacesCubit>(context);
    if (races.filters[widget.index].isEnabled == false) {
      races.filters[widget.index].isEnabled = true;
      races.numberOfFilters += 1;
    }
    races.updateDistanceRange(distanceRange);
    races.filterByDistance();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: OverlayTitle(
              title: 'Distance',
              onPressed: () {
                const HomeAssistFunctions()
                    .onPressResetSingleFilter(context, widget.index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: CustomLocalizedTextWidget(
              stringKey:
                  '${distanceRange.start.round()}K - ${distanceRange.end.round()}K',
              fontSize: 16,
              fontWeight: CustomTextWeight.regularFont,
              color: const Color(0xff1C325F),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: RangeSlider(
                values: distanceRange,
                min: 0,
                max: 250,
                activeColor: const Color(0xffFFB715),
                onChanged: (value) {
                  setState(() {
                    distanceRange = value;
                  });
                }),
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
              height: kScreenWidth > 600
                  ? kScreenHeight * 0.04
                  : kScreenHeight * 0.06,
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
