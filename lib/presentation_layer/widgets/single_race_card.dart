import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_enum.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/data_layer/models/home_page_models/races_data_model.dart';
import 'package:race_app/presentation_layer/app_dialog.dart';
import 'package:race_app/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:race_app/presentation_layer/widgets/single_line_widget.dart';
import 'package:race_app/translations/locale_keys.g.dart';

class SingleRaceCard extends StatelessWidget {
  const SingleRaceCard({super.key, required this.race});
  final RacesDataModel race;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          AppDialog(
            context: context,
            dialogTitle: LocaleKeys.placeHolderText,
            dialogContent: LocaleKeys.placeHolderText,
          ).showTwoOptionsDialog();
        },
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 8,
            color: const Color(0xffF1F4FD),
            child: Stack(
              children: [
                Row(
                  children: [
                    Container(
                      width: kScreenWidth * 0.32,
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, top: 8, bottom: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 10,
                              backgroundColor: AppColors.primary,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Icon(
                                  Icons.star_rate_rounded,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: kScreenWidth * 0.47,
                              child: CustomLocalizedTextWidget(
                                fontSize: Variables.double16,
                                stringKey:
                                    race.name ?? LocaleKeys.placeHolderText,
                                maxLines: 2,
                                isSoftWrapped: true,
                                isThreeDotsInOverFlow: true,
                                fontWeight: CustomTextWeight.blackFont,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const CustomLocalizedTextWidget(
                              fontSize: Variables.double14,
                              stringKey: 'Orgaized by',
                              fontWeight: CustomTextWeight.mediumFont,
                              color: AppColors.lightBlue,
                            ),
                            const SizedBox(
                              height: Variables.five,
                            ),
                            if (race.organizer != '' || race.organizer != null)
                              CustomLocalizedTextWidget(
                                isSoftWrapped: true,
                                isThreeDotsInOverFlow: true,
                                maxLines: 1,
                                fontSize: Variables.double14,
                                stringKey: race.organizer ??
                                    LocaleKeys.placeHolderText,
                                fontWeight: CustomTextWeight.mediumFont,
                                color: AppColors.orange,
                              ),
                            const SizedBox(
                              height: Variables.eight,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      SingleLineWidget(
                                        text: race.distances ?? "",
                                        icon: FontAwesomeIcons.route,
                                      ),
                                      const SizedBox(
                                        height: Variables.five,
                                      ),
                                      SingleLineWidget(
                                        text: race.date != null
                                            ? "${race.date!.substring(0, 4)}/${race.date!.substring(4, 6).toString().padLeft(2, '0')}/${race.date!.substring(6)}"
                                            : "",
                                        icon: FontAwesomeIcons.calendarDays,
                                      ),
                                      const SizedBox(
                                        height: Variables.five,
                                      ),
                                      SingleLineWidget(
                                        text: '${race.city}, ${race.country}',
                                        icon: FontAwesomeIcons.locationDot,
                                      ),
                                      const SizedBox(
                                        height: Variables.double12,
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: InkWell(
                                  child: SvgPicture.asset(
                                      'assets/images/shareIcon.svg'),
                                ))
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  width: kScreenWidth * 0.3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                    child: Image.asset(
                      'assets/images/${race.image}',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
