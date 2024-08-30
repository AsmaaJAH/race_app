import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_enum.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/data_layer/cubits/races_cubit.dart';
import 'package:race_app/data_layer/cubits/visibility_cubit.dart';
import 'package:race_app/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:race_app/presentation_layer/widgets/customized_button.dart';

class TypeOverlay extends StatefulWidget {
  const TypeOverlay({super.key, required this.filterIndex});
  final int filterIndex;
  @override
  State<TypeOverlay> createState() => _TypeOverlayState();
}

class _TypeOverlayState extends State<TypeOverlay> {
  late int pickedTypeIndex;
  @override
  void initState() {
    pickedTypeIndex = BlocProvider.of<RacesCubit>(context).pickedTypeIndex;
    super.initState();
  }

  void _onPressDone(context) {
    BlocProvider.of<VisibilityCubit>(context).turnOnNavBarVisibility();

    var cubit = BlocProvider.of<RacesCubit>(context);
    if (cubit.filters[widget.filterIndex].isEnabled == false) {
      cubit.filters[widget.filterIndex].isEnabled = true;
      cubit.numberOfFilters += 1;
    }
    cubit.updatePickedTypeIndex(pickedTypeIndex);
    cubit.filterByType();
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
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 24, bottom: 16),
            child: CustomLocalizedTextWidget(
              stringKey: 'RACE TYPE',
              fontSize: 22,
              fontWeight: CustomTextWeight.boldFont,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const Divider(
              color: AppColors.primary,
            ),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                setState(() {
                  pickedTypeIndex = index;
                });
              },
              child: CustomTypeListTile(
                isSelected: pickedTypeIndex == index,
                type: Variables.types[index],
              ),
            ),
            itemCount: 3,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 24),
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
          ),
        ],
      ),
    );
  }
}

class CustomTypeListTile extends StatelessWidget {
  const CustomTypeListTile(
      {super.key, this.isSelected = false, required this.type});
  final bool isSelected;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 17, right: 24, left: 24),
      child: Row(
        children: [
          CustomLocalizedTextWidget(
            stringKey: type,
            fontSize: 16,
            fontWeight: CustomTextWeight.regularFont,
          ),
          const Spacer(),
          Container(
            width: 18,
            height: 18,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: AppColors.primary, width: 2)),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.primary : Colors.white),
              width: double.infinity,
              height: double.infinity,
            ),
          )
        ],
      ),
    );
  }
}
