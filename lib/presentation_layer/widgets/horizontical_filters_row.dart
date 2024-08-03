import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/control_layer/managers/themes_manager/text_theme_manager.dart';
import 'package:race_app/data_layer/cubits/races_cubit.dart';
import 'package:race_app/presentation_layer/app_overlay_builder.dart';
import 'package:race_app/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:race_app/presentation_layer/widgets/overlay_widgets/date_overlay.dart';
import 'package:race_app/presentation_layer/widgets/overlay_widgets/distance_overlay.dart';
import 'package:race_app/presentation_layer/widgets/overlay_widgets/location_overlay.dart';
import 'package:race_app/presentation_layer/widgets/overlay_widgets/reset_overlay.dart';
import 'package:race_app/presentation_layer/widgets/overlay_widgets/type_overlay.dart';

class HorizonticalFiltersRow extends StatelessWidget {
  const HorizonticalFiltersRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RacesCubit, RacesStates>(
      builder: (context, state) {
        var cubit = BlocProvider.of<RacesCubit>(context);
        var fixedButton = InkWell(
          onTap: () {
            const AppOverlayBuilder().openOverlayUI(
                context: context, customOverlayWidget: const ResetOverlay());
          },
          child: Container(
            padding: EdgeInsets.all(kScreenWidth * 0.032),
            margin: EdgeInsets.only(left: kScreenWidth * 0.04),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.primary),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.filter,
                  color: AppColors.white,
                  size: kScreenWidth * 0.03,
                ),
                const SizedBox(
                  width: Variables.five,
                ),
                CircleAvatar(
                  radius: 8,
                  backgroundColor: const Color(0xffFFE954),
                  child: CustomLocalizedTextWidget(
                    stringKey: '${cubit.numberOfFilters}',
                    style: TextThemeManager.mediumFont(
                        fontSize: 12, fontColor: AppColors.primary),
                  ),
                )
              ],
            ),
          ),
        );
        var horizontalScrollButtons = Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: cubit.filters
                    .asMap()
                    .entries
                    .map((filter) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            onTap: () {
                              switch (filter.value.filter) {
                                case 'Type':
                                  const AppOverlayBuilder().openOverlayUI(
                                    context: context,
                                    customOverlayWidget: TypeOverlay(
                                      filterIndex: filter.key,
                                    ),
                                  );
                                  break;
                                case 'Location':
                                  const AppOverlayBuilder().openOverlayUI(
                                    context: context,
                                    customOverlayWidget: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: LocationOverlay(
                                        index: filter.key,
                                      ),
                                    ),
                                  );
                                  break;
                                case 'Distance':
                                  const AppOverlayBuilder().openOverlayUI(
                                    context: context,
                                    customOverlayWidget: DistanceOverlay(
                                      index: filter.key,
                                    ),
                                  );
                                  break;

                                case 'Date':
                                  const AppOverlayBuilder().openOverlayUI(
                                    context: context,
                                    customOverlayWidget:
                                        DateOverlay(index: filter.key),
                                  );
                                  break;
                              }
                            },
                            child: filter.value.isEnabled == true
                                ? Container(
                                    width: kScreenWidth * 0.3,
                                    padding: EdgeInsets.only(
                                      left: kScreenWidth * 0.04,
                                      bottom: 8,
                                      right: 8,
                                      top: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.primary,
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CustomLocalizedTextWidget(
                                          stringKey: filter.value.filter,
                                          style: TextThemeManager.mediumFont(
                                            fontSize: 14,
                                            fontColor: AppColors.white,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  )
                                : Container(
                                    width: kScreenWidth * 0.3,
                                    padding: EdgeInsets.only(
                                        left: kScreenWidth * 0.04,
                                        bottom: 8,
                                        right: 8,
                                        top: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: AppColors.primary)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CustomLocalizedTextWidget(
                                            stringKey: filter.value.filter,
                                            style: TextThemeManager.mediumFont(
                                                fontSize: 14)),
                                        const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: AppColors.primary,
                                        )
                                      ],
                                    ),
                                  ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        );
        return Row(
          children: [
            if (cubit.numberOfFilters > Variables.zeroInt) fixedButton,
            if (cubit.numberOfFilters == 0) const SizedBox.shrink(),
            horizontalScrollButtons,
          ],
        );
      },
    );
  }
}
