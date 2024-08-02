import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:race_app/constants/app_enum.dart';
import 'package:race_app/data_layer/models/home_page_models/races_data_model.dart';
part 'races_state.dart';

class RacesCubit extends Cubit<RacesStates> {
  RacesCubit() : super(RacesInitialState());

  RequestStatus raceRequestStatus = RequestStatus.neutral;
  List<RacesDataModel> racesList = [];

  void updateRacesRequestStatus({
    required RequestStatus requestStatus,
    List<RacesDataModel>? list,
  }) {
    raceRequestStatus = requestStatus;

    if (raceRequestStatus == RequestStatus.loading) {
      emit(RacesLoadingState());
    } else if (raceRequestStatus == RequestStatus.completed) {
      racesList = list!;
      emit(RacesSuccessState());
    } else if (raceRequestStatus == RequestStatus.error) {
      emit(RacesFailureState());
    }
  }
}
