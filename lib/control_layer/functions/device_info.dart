
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:race_app/data_layer/models/device_model.dart';
import 'package:race_app/my_app.dart';

class DeviceInfo {
  const DeviceInfo._();

  static var currentDeviceInfo = DeviceModel(
    deviceType: 'unknown',
    mostFavDeviceLangCode: 'en',
  );

  static void determineDeviceType() {
    //------------------------------ device type: "android" , "ios" , "web", "unknown" ------------------------
    if (Platform.isAndroid) {
      currentDeviceInfo.deviceType = "android";
    } else if (Platform.isIOS) {
      currentDeviceInfo.deviceType = "ios";
    } else if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      currentDeviceInfo.deviceType = "web";
    } else {
      currentDeviceInfo.deviceType = "unknown";
    }
  }

//-------------------- language ------------------------------------------
  static void determineDeviceLanguage() async {
    if (kNavigatorKey.currentContext == null) {
      return;
    } else if (!kNavigatorKey.currentContext!.mounted) {
      return;
    } else {
      currentDeviceInfo.mostFavDeviceLangCode = kNavigatorKey
          .currentContext!.deviceLocale
          .toString()
          .split('-')[0]
          .toString();
    }
  }
}
