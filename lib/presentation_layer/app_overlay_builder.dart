import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:race_app/data_layer/cubits/visibility_cubit.dart';

class AppOverlayBuilder {
  const AppOverlayBuilder();

  void openOverlayUI({
    required BuildContext context,
    required Widget customOverlayWidget,
  }) {
    BlocProvider.of<VisibilityCubit>(context).turnOffVisibility();

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => customOverlayWidget,
    ).whenComplete(() {
      BlocProvider.of<VisibilityCubit>(context).turnOnNavBarVisibility();
    });
  }
}
