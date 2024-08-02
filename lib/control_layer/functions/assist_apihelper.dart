
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:race_app/data_layer/models/response_wrapper_model.dart';
import 'package:race_app/presentation_layer/app_snack_bar.dart';


class AssistApiHelper {
  const AssistApiHelper._();

  static printCurrentResults(
      {required String requestType, 
      dynamic requestBody,
      Map<String, String>? headers,
      required Response response}) {
    
    if (headers != null) {
      debugPrint(
        "((------------------------$requestType Headers---------------------)) $headers",
      );
    }
    if (requestBody != null) {
      debugPrint(
          "((-------------------$requestType Request-Body ---------------------))  $requestBody");
    }
    debugPrint(
        "((------------------- response statusCode in $requestType request---------------------))  ${response.statusCode}");
    debugPrint(
        "((-------------response body in $requestType request ---------------------)) ${response.body}");
  }

  static dynamic getDecodedResponse({required String data, String? label}) {
    //decode
    var responseBody = json.decode(data);
    //print
    log(
      responseBody.toString(),
      name: label ?? "(( ----------- Response: ----------))",
    );
    return responseBody;
  }

  static ErrorWrapper? extractTheErrorWrapper(Response response) {
    try {
      final Map<String, dynamic> errorMap = json.decode(response.body);
      log("${errorMap['error']}", name: "Error");
      log("${errorMap["message"]}", name: "message");
      if (errorMap['error'] is String) {
        return ErrorWrapper(
            error: errorMap['error'], message: errorMap['message']);
      } else if (errorMap["message"] != null) {
        return ErrorWrapper(
            error: errorMap['message'], message: errorMap['message']);
      }
      return ErrorWrapper(
          error: errorMap['error'], message: errorMap['message']);
    } catch (error) {
      log("------- ***--***---*** -------", name: "Error catch");
      log("((----------***--------  Response Request -------***---------)) ${response.request}");
      return const ErrorWrapper(
          error: 'Parsing error during excuting extractErrorWrapper function',
          message:
              'Parsing error during excuting extractErrorWrapper function');
    }
  }

  static void showUIErrorWarning({required BuildContext snackBarContext}) {
    // ignore: use_build_context_synchronously
    if (!snackBarContext.mounted) {
      return;
    }
    AppSnackBar(
            isError: true,
            context: snackBarContext,
            message: "Something went wrong, please try again later!")
        .showAppSnackBar();
  }

}
