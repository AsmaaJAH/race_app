import 'package:flutter/material.dart';

class AppOverlayBuilder {
  const AppOverlayBuilder();

  void openOverlayUI({
    required BuildContext context,
    required Widget customOverlayWidget,
  }) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => customOverlayWidget,
    );
  }
}
