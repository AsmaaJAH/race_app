import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:race_app/constants/app_enum.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/control_layer/utilities/extensions.dart';
import 'package:race_app/data_layer/models/home_page_models/button_filter_model.dart';
import 'package:race_app/data_layer/models/home_page_models/races_data_model.dart';
part 'races_state.dart';

class RacesCubit extends Cubit<RacesStates> {
  RacesCubit() : super(RacesInitialState());
  bool isTryingToFind = false;
  bool isSearchingByCountry = false;

  RequestStatus raceRequestStatus = RequestStatus.neutral;
  List<RacesDataModel> racesList = [];
  List<RacesDataModel> exploreList = [];
  List<RacesDataModel> list = [];

  int index = 0;
  int pageSize = 10;
  int numberOfFilters = 0;
  List<ButtonFilterModel> filters = [
    ButtonFilterModel(filter: 'Type'),
    ButtonFilterModel(filter: 'Location'),
    ButtonFilterModel(filter: 'Distance'),
    ButtonFilterModel(filter: 'Date'),
  ];
  int pickedTypeIndex = 0;
  List<String> pickedLocations = [];
  RangeValues distanceRange = const RangeValues(0, 200);
  DateTime initalDate = DateTime.now();
  DateTime finalDate = DateTime.now();

  void updatePickedTypeIndex(int value) {
    pickedTypeIndex = value;
    emit(RacesSuccessState());
  }

  void updatePickedLocations(List<String> value) {
    pickedLocations = value;
    emit(RacesSuccessState());
  }

  void updateDistanceRange(RangeValues value) {
    distanceRange = value;
    emit(RacesSuccessState());
  }

  void updateInitalDate(DateTime value) {
    initalDate = value;
    emit(RacesSuccessState());
  }

  void updateFinalDate(DateTime value) {
    finalDate = value;
    emit(RacesSuccessState());
  }

  void updateRacesRequestStatus({
    required RequestStatus requestStatus,
    List<RacesDataModel>? list,
  }) {
    raceRequestStatus = requestStatus;

    if (raceRequestStatus == RequestStatus.loading) {
      emit(RacesLoadingState());
    } else if (raceRequestStatus == RequestStatus.completed) {
      racesList = list!;
      while (index < 10 &&
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
    exploreList = racesList.where((item) {
      if ( //search value is a country
          item.country != null &&
              (item.country!.contains(value.trim()) ||
                  item.country!.contains(value.inCapitals.trim()) ||
                  item.country!.contains(value.allInCapitals.trim()) ||
                  item.country!.contains(value.capitalizeFirstOfEach.trim()))) {
        isSearchingByCountry = true;
        pickedLocations.add(item.country!);
        return true;
      } else {
        isSearchingByCountry = false;
        return item.name!.contains(value.trim()) ||
            item.name!.contains(value.inCapitals.trim()) ||
            item.name!.contains(value.allInCapitals.trim()) ||
            item.name!.contains(value.capitalizeFirstOfEach.trim()) ||
            item.city!.contains(value.trim()) ||
            item.city!.contains(value.inCapitals.trim()) ||
            item.city!.contains(value.allInCapitals.trim()) ||
            item.city!.contains(value.capitalizeFirstOfEach.trim());
      }
    }).toList();

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

  void filterByType() {
    //there are other active filters or search
    if (isTryingToFind) {
      list = exploreList;
    } else {
      list = racesList;
    }
    if (Variables.types[pickedTypeIndex] == 'Real-time event') {
      exploreList =
          list.where((element) => element.type == 'Real-time').toList();
    } else if (Variables.types[pickedTypeIndex] == 'Virtual') {
      exploreList = list.where((element) => element.type == 'Virtual').toList();
    } else {
      exploreList = list;
      numberOfFilters -= 1;
      filters[0].isEnabled = false;
    }
    isTryingToFind = true;
    emit(RacesSuccessState());
  }

  void filterByLocation() {
    //there are other active filters or search
    if (isTryingToFind) {
      list =
          exploreList; //find a matched element from the previous exploredList only
    } else {
      list = racesList; //filter all matched elements
    }
    List<RacesDataModel> temp = [];
    for (var item in pickedLocations) {
      temp.addAll([...list.where((element) => element.country == item)]);
    }
    //update the exploreList
    exploreList = temp;
    isTryingToFind = true;
    emit(RacesSuccessState());
  }

  void filterByDistance() {
    List<RacesDataModel> tempItems = [];
    bool itemIsVlid = false;
    //if there are other active filters or search
    if (isTryingToFind) {
      list = exploreList;
    } else {
      list = racesList;
    }
    for (var item in list) {
      List<String> parts = item.distances!.split(','); //from assets
      List<double> numbers = parts.map((part) {
        String numericString = part.split('K')[0];
        return double.parse(numericString);
      }).toList();
      for (var number in numbers) {
        if (number >= distanceRange.start && number <= distanceRange.end) {
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

  void filterByDate() {
    //there are other active filters or search
    if (isTryingToFind) {
      list =
          exploreList; //find a matched element from the previous exploredList only
    } else {
      list = racesList; //filter all matched elements
    }
    List<RacesDataModel> temp = [];
    for (int index = 0; index < list.length; index++) {
      final DateTime? raceDate =
          list[index].date != null ? DateTime.parse(list[index].date!) : null;
      if (raceDate != null &&
          raceDate.isBefore(finalDate) &&
          raceDate.isAfter(initalDate)) {
        temp.add(list[index]);
      }
    }
    exploreList = temp;
    isTryingToFind = true;
    emit(RacesSuccessState());
  }

  void reset({int? index}) {
    isTryingToFind =
        false; //reset it to false temporary in all cases, and make it true inside each filter only
    if (index == null) {
      exploreList = racesList;
      for (int index = 0; index < filters.length; index++) {
        filters[index].isEnabled = false;
      }

      numberOfFilters = 0;
      pickedTypeIndex = 0;
      pickedLocations = [];
      distanceRange = const RangeValues(0, 200);
      initalDate = DateTime.now();
      finalDate = DateTime.now();
      emit(RacesSuccessState());
    } else {
      filters[index].isEnabled = false;
      numberOfFilters -= 1;
      if (numberOfFilters == 0) {
        exploreList = racesList;
      } else {
        //update the exploreList with the remaining filters only:
        for (int index = 0; index < filters.length; index++) {
          if (filters[index].isEnabled) {
            switch (filters[index].filter) {
              case 'Type':
                filterByType();
                break;
              case 'Location':
                filterByLocation();
                break;
              case 'Distance':
                filterByDistance();
                break;
              case 'Date':
                filterByDate();
                break;
            }
          }
        }
      }
      emit(RacesSuccessState());
    }
  }
}
