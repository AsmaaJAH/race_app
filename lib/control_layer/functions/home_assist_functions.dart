import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:race_app/data_layer/cubits/races_cubit.dart';

class HomeAssistFunctions {
  const HomeAssistFunctions();

  void onPressResetSingleFilter(context, idx) {
    RacesCubit cubit = BlocProvider.of<RacesCubit>(context);

    if (cubit.filters[idx].isEnabled) {
      cubit.filters[idx].isEnabled = false;
      cubit.reset(index: idx);
      switch (cubit.filters[idx].filter) {
        case 'Type':
          cubit.updatePickedTypeIndex(0);
          break;
        case 'Location':
          cubit.updatePickedLocations([]);
          break;
        case 'Distance':
          cubit.updateDistanceRange(const RangeValues(0, 250));
          break;
        case 'Date':
          cubit.updateInitalDate(DateTime.now());
          cubit.updateFinalDate(DateTime.now());
          break;
      }
    }

    Navigator.of(context).pop();
  }
}
