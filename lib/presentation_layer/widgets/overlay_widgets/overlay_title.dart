import 'package:flutter/material.dart';
import 'package:race_app/control_layer/managers/themes_manager/text_theme_manager.dart';

class OverlayTitle extends StatelessWidget {
  const OverlayTitle({super.key, this.onPressed, required this.title});
  final void Function()? onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const TextButton(
            onPressed: null,
            child: Text(
              'Reset',
              style: TextStyle(color: Colors.white),
            )),
        Text(
          title,
          style: TextThemeManager.boldFont(fontSize: 22),
        ),
        TextButton(
            onPressed: onPressed,
            child: const Text(
              'Reset',
              style: TextStyle(color: Color(0xffBD5000)),
            ))
      ],
    );
  }
}
