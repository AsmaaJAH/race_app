import 'package:flutter/material.dart';
import 'package:race_app/constants/app_colors.dart';
// import 'package:race_app/constants/app_enum.dart';
import 'package:race_app/constants/app_image_paths.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
// import 'package:race_app/constants/variables.dart';
// import 'package:race_app/presentation_layer/app_dialog.dart';
// import 'package:race_app/presentation_layer/app_snack_bar.dart';
// import 'package:race_app/presentation_layer/widgets/customized_button.dart';
// import 'package:race_app/presentation_layer/widgets/linear_circular_progress_indicator.dart';
// import 'package:race_app/translations/locale_keys.g.dart';


//===============================================================================================
//------ Hello, I am just a debuger & functional tester for Asmaa, feel free to delete me -------
//===============================================================================================
class DeleteMe extends StatelessWidget {
  const DeleteMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 20,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              AppImagesPaths.logo,
              width: kScreenWidth * 0.25,
              height: kScreenWidth * 0.25,
              fit: BoxFit.fitHeight,
            ),
            // CustomizedButton(
            //     width: Variables.buttonDefaultwidth,
            //     trailer: const Icon(
            //       Icons.shop_two,
            //       color: AppColors.white,
            //     ),
            //     leading: const Icon(
            //       Icons.family_restroom,
            //       color: Colors.white,
            //     ),
            //     buttonText: LocaleKeys.placeHolderText,
            //     onPressed: () {
            //       AppDialog(
            //         context: context,
            //         dialogTitle: LocaleKeys.placeHolderText,
            //         dialogContent: LocaleKeys.placeHolderText,
            //       ).showTwoOptionsDialog();
            //     }),
            // const SizedBox(
            //   height: Variables.double30,
            // ),
            // CustomizedButton(
            //   textColor: AppColors.secondary,
            //   backgroundColor: Colors.white,
            //   borderColor: AppColors.secondary,
            //   borderRadius: Variables.double20,
            //   width: Variables.double200,
            //   fontSize: Variables.double15,
            //   fontWeight: CustomTextWeight.boldFont,
            //   buttonText: LocaleKeys.placeHolderText,
            //   onPressed: () {
            //     AppSnackBar(
            //       context: context,
            //       message: LocaleKeys.placeHolderText,
            //       isError: false,
            //     ).showAppSnackBar();
            //   },
            // ),
            // const SizedBox(
            //   height: Variables.double24,
            // ),
            // const LinearCircularProgressIndicator(
            //     isLinearProgressIndicator: false),
          ],
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(Variables.eight),
      //   child: CustomizedButton(
      //     height: Variables.double60,
      //     width: Variables.double250,
      //     borderRadius: Variables.double30,
      //     elevation: Variables.ten,
      //     onPressed: () {
      //      // const AppOverlayBuilder().openOverlayUI(context: context);
      //     },
      //     buttonText: LocaleKeys.placeHolderText,
      //   ),
      // ),
    );
  }
}
