import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_enum.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/control_layer/functions/home_assist_functions.dart';
import 'package:race_app/control_layer/managers/themes_manager/text_theme_manager.dart';
import 'package:race_app/data_layer/cubits/races_cubit.dart';
import 'package:race_app/data_layer/models/home_page_models/location_data_model.dart';
import 'package:race_app/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:race_app/presentation_layer/widgets/customized_button.dart';
import 'package:race_app/presentation_layer/widgets/overlay_widgets/overlay_title.dart';
import 'package:race_app/presentation_layer/widgets/search_bar_widget.dart';

class LocationOverlay extends StatefulWidget {
  const LocationOverlay({super.key, required this.index});
  final int index;
  @override
  State<LocationOverlay> createState() => _LocationOverlayState();
}

class _LocationOverlayState extends State<LocationOverlay> {
  void _onPressDone(context) {
    if (BlocProvider.of<RacesCubit>(context).filters[widget.index].isEnabled ==
        false) {
      BlocProvider.of<RacesCubit>(context).filters[widget.index].isEnabled =
          true;
      BlocProvider.of<RacesCubit>(context).numberOfFilters += 1;
    }
    List<String> pickedLocations = [];
    for (var item in Variables.locations) {
      if (item.isSelected == true) {
        pickedLocations.add(item.location.split(' ')[0]);
      }
    }
    BlocProvider.of<RacesCubit>(context).filterByLocation(pickedLocations);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kScreenHeight * 0.7,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: OverlayTitle(
              title: 'RACE LOCATION',
              onPressed: () {
                const HomeAssistFunctions()
                    .onPressResetSingleFilter(context, widget.index);
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SearchBarWidget(
              searchBarHint: 'Search',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
              child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                setState(() {
                  Variables.locations[index].isSelected =
                      !Variables.locations[index].isSelected;
                  debugPrint("${Variables.locations[index].isSelected}");
                });
              },
              child: CustomLocationListile(
                index: index,
                place: Variables.locations[index],
              ),
            ),
            itemCount: Variables.locations.length,
          )),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}

class CustomLocationListile extends StatefulWidget {
  const CustomLocationListile(
      {super.key, required this.place, required this.index});
  final LocationDataModel place;
  final int index;

  @override
  State<CustomLocationListile> createState() => _CustomLocationListileState();
}

class _CustomLocationListileState extends State<CustomLocationListile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomLocalizedTextWidget(
            stringKey: widget.place.location,
            style: widget.index == 0
                ? TextThemeManager.boldFont(fontSize: 16)
                : TextThemeManager.regularFont(fontSize: 16),
          ),
          Checkbox(
            value: widget.place.isSelected,
            onChanged: (value) {
              setState(() {
                widget.place.isSelected = !widget.place.isSelected;
              });
            },
            checkColor: Colors.white,
            activeColor: const Color(0xff1C325F),
            side: const BorderSide(color: Color(0xff1C325F), width: 2),
          )
        ],
      ),
    );
  }
}
