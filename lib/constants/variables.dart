//Conventions contains const values or convenant-agreement variables
//that all the project developers agree on using them in the whole app
import 'package:flutter/material.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/data_layer/models/home_page_models/location_data_model.dart';

class Variables {
  //----------------------------- Strings-----------------------------

  static String currentLanguageCode = "";
  static const String enLangCode = "en";
  static const String arLangCode = "ar";
  static const String enCountryCode = "US";
  static const String arCountryCode = "SA";

  static const enUsLocale =
      Locale(Variables.enLangCode, Variables.enCountryCode);
  static const arSaLocale =
      Locale(Variables.arLangCode, Variables.arCountryCode);

//-----------Presentation layer strings:
  //---------Widgets:
  //--buttons:
  static const double buttonDefaultHeight = 44.0;
  static final double buttonDefaultwidth = kScreenWidth * 0.9;

  //--- OverlayBuilder:
  static const List<String> types = ['Real-time event', 'Virtual', 'All'];
  static final List<LocationDataModel> locations = [
    LocationDataModel(location: 'NEAR MY LOCATION '),
    LocationDataModel(location: 'Egypt (3)'),
    LocationDataModel(location: 'France (7)'),
    LocationDataModel(location: 'Germany (9)'),
    LocationDataModel(location: 'Greece (4)'),
    LocationDataModel(location: 'Italy (9)'),
    LocationDataModel(location: 'Kuwait (2)'),
  ];

  //--- Linear-circular indicator:
  static const double strokeAlignCenter = 0.0;

//------ HomePage:
  static const String race = "Race";

  //----------------------------- const numbers ----------------------
  static const double double0_01 = 0.01;
  static const double double0_3 = 0.3;

  static const double double0_5 = 0.5;
  static const double double0_7 = 0.7;

  static const double zero = 0.0;
  static const double one = 1.0;
  static const double two = 2.0;
  static const double three = 3.0;
  static const double four = 4.0;
  static const double five = 5.0;
  static const double six = 6.0;
  static const double seven = 7.0;
  static const double eight = 8.0;
  static const double nine = 9.0;
  static const double ten = 10.0;
  static const double double11 = 11.0;
  static const double double12 = 12.0;
  static const double double13 = 13.0;
  static const double double14 = 14.0;
  static const double double14_4 = 14.4;

  static const double double15 = 15.0;
  static const double double16 = 16.0;
  static const double double17 = 17.0;
  static const double double18 = 18.0;
  static const double double19 = 19.0;
  static const double double20 = 20.0;

  static const double double22 = 22.0;

  static const double double23 = 23.0;

  static const double double24 = 24.0;

  static const double double26 = 26.0;

  static const double double28 = 28.0;

  static const double double30 = 30.0;

  static const double double32 = 32.0;

  static const double double35 = 35.0;

  static const double double37 = 37.0;

  static const double double44 = 44.0;

  static const double double60 = 60.0;

  static const double double65 = 65.0;

  static const double double70 = 70.0;
  static const double double100 = 100.0;
  static const double double110 = 110.0;

  static const double double150 = 150.0;
  static const double double160 = 160.0;

  static const double double200 = 200.0;
  static const double double250 = 250.0;
  static const double double300 = 300.0;

  //negative:
  static const double ngtveOne = -1.0;

  // integers:
  static const int zeroInt = 0;
  static const int oneInt = 1;
  static const int twoInt = 2;
  static const int threeInt = 3;
  static const int fourInt = 4;
  static const int fiveInt = 5;
  static const int sixInt = 6;

  static const int int14 = 14;
  static const int int16 = 16;

  static const int int26 = 26;
  static const int int27 = 27;

  static const int int34 = 34;
  static const int int35 = 35;

  static const int int57 = 57;

  static const int int60 = 60;

  static const int int70 = 70;

  static const int int76 = 76;

  static const int int92 = 92;

  static const int int200 = 200;

  static const int int500 = 500;

  static const int int750 = 750;

  static const int int1000 = 1000;

  static const int int2000 = 2000;
  static const int int2200 = 2200;
  static const int int2500 = 2500;
  static const int int3500 = 3500;
}
