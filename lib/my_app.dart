import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/control_layer/managers/themes_manager/mode_themes_manager.dart';
import 'package:race_app/data_layer/cubits/races_cubit.dart';
import 'package:race_app/presentation_layer/screens/splash_screen.dart';

GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    knowScreenWidth(context);
    knowScreenHeight(context);
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => RacesCubit())],
      child: MaterialApp(
        title: 'Races',
        debugShowCheckedModeBanner: false,
        theme: ModeThemeManager.lightThemes,
        darkTheme: ModeThemeManager.darkThemes,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        navigatorKey: kNavigatorKey,
       home: const SafeArea(
            minimum: EdgeInsets.all(Variables.two),
            child: SplashScreen(),
          ),
      ),
    );
  }
}
