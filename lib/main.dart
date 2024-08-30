import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/control_layer/functions/device_info.dart';
import 'package:race_app/control_layer/utilities/my_bloc_observer.dart';
import 'package:race_app/my_app.dart';

void main()  async {
  Bloc.observer = MyBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  DeviceInfo.determineDeviceType();
  DeviceInfo.determineDeviceLanguage();
  
  runApp(
    EasyLocalization(
      supportedLocales: const [Variables.enUsLocale, Variables.arSaLocale],
      path: 'assets/translations',
      fallbackLocale: Variables.enUsLocale,
      child: const MyApp(),
    ),
  );
}
