import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:race_app/constants/app_enum.dart';
import 'package:race_app/control_layer/utilities/extensions.dart';
import 'package:race_app/data_layer/models/home_page_models/button_filter_model.dart';
import 'package:race_app/data_layer/models/home_page_models/races_data_model.dart';
part 'races_state.dart';

class RacesCubit extends Cubit<RacesStates> {
  RacesCubit() : super(RacesInitialState());
  bool isTryingToFind = false;


  RequestStatus raceRequestStatus = RequestStatus.neutral;
  List<RacesDataModel> racesList = [];
  List<RacesDataModel> exploreList = [];
  int index = 0;
  int pageSize = 10;
  int numberOfFilters = 0;
  List<ButtonFilterModel> filters = [
    ButtonFilterModel(filter: 'Type'),
    ButtonFilterModel(filter: 'Location'),
    ButtonFilterModel(filter: 'Distance'),
    ButtonFilterModel(filter: 'Date'),
  ];

  void updateRacesRequestStatus({
    required RequestStatus requestStatus,
    List<RacesDataModel>? list,
  }) {
    raceRequestStatus = requestStatus;

    if (raceRequestStatus == RequestStatus.loading) {
      emit(RacesLoadingState());
    } else if (raceRequestStatus == RequestStatus.completed) {
      racesList = list!;
      while (index < 5 &&
          exploreList.length != racesList.length &&
          index < pageSize) {
        exploreList.add(racesList[index]);
        index++;
      }
      emit(RacesSuccessState());
    } else if (raceRequestStatus == RequestStatus.error) {
      emit(RacesFailureState());
    }
  }

  void search(String value) {
    exploreList = racesList
        .where((item) =>
            item.name!.contains(value.trim()) ||
            item.name!.contains(value.inCapitals.trim()) ||
            item.name!.contains(value.allInCapitals.trim()) ||
            item.name!.contains(value.capitalizeFirstOfEach.trim()) ||
            item.city!.contains(value.trim()) ||
            item.city!.contains(value.inCapitals.trim()) ||
            item.city!.contains(value.allInCapitals.trim()) ||
            item.city!.contains(value.capitalizeFirstOfEach.trim()) ||
            item.country!.contains(value.trim()) ||
            item.country!.contains(value.inCapitals.trim()) ||
            item.country!.contains(value.allInCapitals.trim()) ||
            item.country!.contains(value.capitalizeFirstOfEach.trim()))
        .toList();

    isTryingToFind = true;
    emit(RacesSuccessState());
  }

  void pagination() {
    while (index < racesList.length &&
        exploreList.length != racesList.length &&
        index < pageSize &&
        isTryingToFind != true) {
      exploreList.add(racesList[index]);
      index++;
    }
    emit(RacesSuccessState());
  }

  void filterByType(String type) {
    if (type == 'Real-time event') {
      exploreList =
          racesList.where((element) => element.type == 'Real-time').toList();
    } else if (type == 'Virtual') {
      exploreList =
          racesList.where((element) => element.type == 'Virtual').toList();
    } else {
      exploreList = racesList;
      numberOfFilters -= 1;
      filters[0].isEnabled = false;
    }
    isTryingToFind = true;
    emit(RacesSuccessState());
  }

  void filterByLocation(List<String> locations) {
    List<RacesDataModel> temp = [];
    for (var item in locations) {
      temp.addAll([...racesList.where((element) => element.country == item)]);
    }
    exploreList = temp;
    isTryingToFind = true;
    emit(RacesSuccessState());
  }

  void filterByDistance(double value1, double value2) {
    List<RacesDataModel> tempItems = [];
    bool itemIsVlid = false;

    for (var item in racesList) {
      List<String> parts = item.distances!.split(','); //from assets
      List<double> numbers = parts.map((part) {
        String numericString = part.split('K')[0];
        return double.parse(numericString);
      }).toList();
      for (var number in numbers) {
        if (number >= value1 && number <= value2) {
          itemIsVlid = true;
        } else {
          itemIsVlid = false;
        }
      }
      if (itemIsVlid) {
        tempItems.add(item);
      }
    }
    exploreList = tempItems;
    isTryingToFind = true;
    emit(RacesSuccessState());
  }

  void filterByDate(DateTime initalDate, DateTime finalDate) {
    List<RacesDataModel> temp = [];
    for (int index = 0; index < racesList.length; index++) {
      final DateTime? raceDate = racesList[index].date != null
          ? DateTime.parse(racesList[index].date!)
          : null;
      if (raceDate != null &&
          raceDate.isBefore(finalDate) &&
          raceDate.isAfter(initalDate)) {
        temp.add(racesList[index]);
      }
    }
    exploreList = temp;
    isTryingToFind = true;
    emit(RacesSuccessState());
  }

  void reset({int? index}) {
    if (index == null) {
      exploreList = racesList;
      for (int index = 0; index < filters.length; index++) {
        filters[index].isEnabled = false;
      }

      numberOfFilters = 0;
      isTryingToFind = true;
      emit(RacesSuccessState());
    } else {
      filters[index].isEnabled = false;
      numberOfFilters -= 1;
      exploreList = racesList;
      emit(RacesSuccessState());
    }
  }
}
