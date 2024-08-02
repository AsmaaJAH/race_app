import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:race_app/constants/app_enum.dart';
import 'package:race_app/control_layer/functions/assist_apihelper.dart';
import 'package:race_app/data_layer/cubits/races_cubit.dart';
import 'package:race_app/data_layer/models/response_wrapper_model.dart';
import 'package:race_app/my_app.dart';

class ApiHelper {
  static final ApiHelper _singleton = ApiHelper._internal();
  ApiHelper._internal();

  factory ApiHelper() {
    return _singleton;
  }

//---------------------------------- GET ------------------------------------------------------------

  Future<ResponseWrapperModel?> getRequest(
      {bool isSnackBarErrorShown = false}) async {
    try {
      final String response = await rootBundle.loadString(
        'assets/races_data.json',
      );

      return ResponseWrapperModel.success(responseBody: response);
    } catch (error) {
      if (kNavigatorKey.currentContext == null) {
        return null;
      } else if (!kNavigatorKey.currentContext!.mounted) {
        return null;
      } else {
        final RacesCubit racesBlocProvider =
            BlocProvider.of<RacesCubit>(kNavigatorKey.currentContext!);

        racesBlocProvider.updateRacesRequestStatus(
          requestStatus: RequestStatus.error,
        );
        debugPrint(
          '((--------------- error in GET request ----------------)) $error',
        );

        // show snack bar, if desired:
        if (isSnackBarErrorShown && kNavigatorKey.currentContext != null) {
          //the below ignorance is because i handled it inside the function itself
          // ignore: use_build_context_synchronously
          AssistApiHelper.showUIErrorWarning(
            snackBarContext: kNavigatorKey.currentContext!,
          );
        }
      }
      return null;
    }
  }
}
