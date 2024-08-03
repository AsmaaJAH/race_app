import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'visibility_state.dart';

class VisibilityCubit extends Cubit<VisibilityStates> {
  VisibilityCubit() : super(VisibilityInitialState());

  bool isVisible = true;
  //visibality:
  void turnOnNavBarVisibility() {
    isVisible = true;
    emit(VisibleNavBarState());
  }

  void turnOffVisibility() {
    isVisible = false;
    emit(HiddenNavBarState());
  }
}
