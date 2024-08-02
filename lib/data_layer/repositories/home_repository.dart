import 'package:flutter/material.dart';
import 'package:race_app/constants/app_enum.dart';
import 'package:race_app/data_layer/cubits/races_cubit.dart';
import 'package:race_app/data_layer/models/home_page_models/races_data_model.dart';
import 'package:race_app/data_layer/models/response_wrapper_model.dart';
import 'package:race_app/data_layer/services/home_services.dart';
import 'package:race_app/presentation_layer/app_snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeRepository {
  final HomeService _homeService = HomeService();
  late RacesCubit homeBlocProvider;
  BuildContext context;

  HomeRepository(this.context) {
    homeBlocProvider = BlocProvider.of<RacesCubit>(context);
  }

  Future<ResponseWrapperModel?> getRacesList(BuildContext context) async {
    homeBlocProvider.updateRacesRequestStatus(
        requestStatus: RequestStatus.loading);
    ResponseWrapperModel? response = await _homeService.getList();
    if (response != null && response.isSucceeded) {
      final apiData = (response.responseBody as List<dynamic>);
      final List<RacesDataModel> data = [];
      for (var element in apiData) {
        data.add(RacesDataModel.fromJson(element));
      }

      homeBlocProvider.updateRacesRequestStatus(
          requestStatus: RequestStatus.completed, list: data);
    } else if (response != null && response.error != null) {
      homeBlocProvider.updateRacesRequestStatus(
          requestStatus: RequestStatus.error);
      if (!context.mounted) {
        return response;
      }
      //it'll never fail in race app with the asset's race data:
      AppSnackBar(
        context: context,
        message: response.error!.message,
        isError: true,
      ).showAppSnackBar();
    }
    return response;
  }
}
