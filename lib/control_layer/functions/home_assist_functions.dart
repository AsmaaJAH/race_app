import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:race_app/data_layer/cubits/races_cubit.dart';

class HomeAssistFunctions {
  const HomeAssistFunctions();

  void onPressResetSingleFilter(context, idx) {
    RacesCubit cubit = BlocProvider.of<RacesCubit>(context);

    if (cubit.filters[idx].isEnabled == true) {
      cubit.filters[idx].isEnabled = false;
      cubit.reset(index: idx);
    }
    Navigator.of(context).pop();
  }
}
