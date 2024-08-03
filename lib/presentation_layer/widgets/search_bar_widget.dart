import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/control_layer/managers/themes_manager/text_theme_manager.dart';
import 'package:race_app/data_layer/cubits/races_cubit.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
    required this.searchBarHint,
    this.onChanged,
  });
  final String searchBarHint;
  final void Function(String)? onChanged;
  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late final TextEditingController controller;
  bool isFocused = false;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTap: () {
        setState(() {
          isFocused = true;
        });
      },
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      onChanged: widget.onChanged,
      onTapOutside: widget.onChanged == null
          ? null
          : (event) {
              setState(() {
                isFocused = false;
              });
              FocusManager.instance.primaryFocus?.unfocus();
            },
      decoration: InputDecoration(
          suffixIcon: isFocused ||
                  (controller.text.isNotEmpty && widget.onChanged != null)
              ? IconButton(
                  onPressed: () {
                    controller.clear();
                    BlocProvider.of<RacesCubit>(context).search('');
                    FocusManager.instance.primaryFocus?.unfocus();
                    isFocused = false;
                  },
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: AppColors.secondary,
                  ))
              : isFocused
                  ? null
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          isFocused = true;
                        });
                      },
                      icon: const Icon(
                        Icons.search,
                        color: AppColors.primary,
                      )),
          hintText: widget.searchBarHint,
          hintStyle: TextThemeManager.regularFont(fontSize: 16),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffCDD3E4), width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: AppColors.secondary, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: Color(0xffCDD3E4), width: 2))),
    );
  }
}
