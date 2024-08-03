import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/control_layer/managers/themes_manager/text_theme_manager.dart';
import 'package:race_app/data_layer/cubits/races_cubit.dart';
import 'package:race_app/presentation_layer/screens/home_page_screen.dart';
import 'package:race_app/presentation_layer/widgets/custom_localized_text_widget.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
    this.searchBarHint,
    this.searchController,
    this.onChanged,
  });
  final String? searchBarHint;
  final SearchController? searchController;
  final void Function(String)? onChanged;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kScreenWidth * 0.8,
      height: kScreenHeight * 0.06,
      child: SearchAnchor(
        searchController: widget.searchController,
        viewBackgroundColor: AppColors.white,
        viewSurfaceTintColor: AppColors.white,
        dividerColor: AppColors.primary,
        isFullScreen: false,
        builder: (
          BuildContext context,
          SearchController controller,
        ) {
          return SearchBar(
            controller: controller,
            focusNode: _focusNode,
            hintText: widget.searchBarHint?.tr(),
            textStyle: WidgetStateProperty.resolveWith(
              (states) => TextThemeManager.lightFont(
                fontColor: AppColors.primary,
                fontSize: Variables.double13,
              ),
            ),
            hintStyle: WidgetStateProperty.resolveWith(
              (states) {
                return TextThemeManager.lightFont(
                  fontColor: AppColors.lightBlue,
                  fontSize: Variables.double16,
                );
              },
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Variables.five),
              ),
            ),
            side: WidgetStateProperty.resolveWith<BorderSide>(
              (states) {
                if (states.contains(WidgetState.focused)) {
                  return const BorderSide(
                    width: Variables.double0_5,
                    color: AppColors.secondary,
                  );
                } else {
                  return const BorderSide(
                    width: Variables.double0_5,
                    color: AppColors.lightBlue,
                  );
                }
              },
            ),
            padding: const WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(
                horizontal: Variables.double16,
              ),
            ),
            onTap: () {
              //controller.openView();
              //isFocus = !isFocus;
            },
            onChanged: (input) {
              //controller.openView();
              BlocProvider.of<RacesCubit>(context).search(input);
            },
            trailing: [
              _isFocused
                  ? IconButton(
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const HomePageScreen(),
                          withNavBar: true,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      icon: const Icon(Icons.cancel_outlined),
                      color: AppColors.secondary,
                    )
                  : IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: AppColors.primary,
                      ),
                    )
            ],
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) => AppColors.white,
            ),
            overlayColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) => AppColors.white,
            ),
            shadowColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) => AppColors.white,
            ),
            surfaceTintColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) => AppColors.white,
            ),
            elevation: WidgetStateProperty.resolveWith<double>(
              (Set<WidgetState> states) => Variables.zero,
            ),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(
            1,
            (int index) {
              final String item = 'item $index';
              return ListTile(
                minLeadingWidth: kScreenWidth * 0.7,
                textColor: AppColors.primary,
                tileColor: AppColors.secondary,
                title: CustomLocalizedTextWidget(
                  stringKey: item,
                ),
                onTap: () {
                  controller.closeView(item);
                },
              );
            },
          );
        },
      ),
    );
  }
}
