import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:race_app/constants/app_colors.dart';
import 'package:race_app/constants/app_image_paths.dart';
import 'package:race_app/constants/app_screen_dimensions.dart';
import 'package:race_app/constants/variables.dart';
import 'package:race_app/data_layer/cubits/races_cubit.dart';
import 'package:race_app/data_layer/repositories/home_repository.dart';
import 'package:race_app/presentation_layer/widgets/horizontical_filters_row.dart';
import 'package:race_app/presentation_layer/widgets/single_race_card.dart';
import 'package:race_app/presentation_layer/widgets/linear_circular_progress_indicator.dart';
import 'package:race_app/presentation_layer/widgets/search_bar_widget.dart';

class RacesBodyWidgets extends StatefulWidget {
  const RacesBodyWidgets({super.key});

  @override
  State<RacesBodyWidgets> createState() => _RacesBodyWidgetsState();
}

class _RacesBodyWidgetsState extends State<RacesBodyWidgets>
    with AutomaticKeepAliveClientMixin<RacesBodyWidgets> {
  var isLoading = false;
  late HomeRepository _homeRepository;
  late RacesCubit _cubit;

  List<Widget> _slivers(context, cubit) => [
        SliverPadding(
            padding: EdgeInsets.only(
              top: kScreenWidth * 0.055,
              left: kScreenWidth * 0.04,
              right: kScreenWidth * 0.04,
              bottom: kScreenWidth * 0.04,
            ),
            sliver: const SliverToBoxAdapter(child: SearchBarWidget())),
        const SliverToBoxAdapter(
          child: HorizonticalFiltersRow(),
        ),
        SliverPadding(
          padding: EdgeInsets.only(
            top: kScreenWidth * 0.055,
            left: kScreenWidth * 0.04,
            right: kScreenWidth * 0.04,
          ),
          sliver: SliverList.builder(
            itemBuilder: (context, index) =>
                SingleRaceCard(race: cubit.exploreList[index]),
            itemCount: cubit.exploreList.length,
          ),
        ),
        if (isLoading)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.sizeOf(context).height * 0.05),
              child: const Center(
                child: LinearCircularProgressIndicator(
                  isLinearProgressIndicator: false,
                  color: AppColors.secondary,
                  circularProgressWidth: Variables.double65,
                  circularProgressHeight: Variables.double65,
                  strokeWidth: Variables.five,
                ),
              ),
            ),
          )
      ];
  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<RacesCubit>(context);
    _homeRepository = HomeRepository(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _homeRepository.getRacesList(context);
    });
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<RacesCubit, RacesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        _cubit = BlocProvider.of<RacesCubit>(context);
        if (state is RacesFailureState) {
          return Center(
            child: Image.asset(AppImagesPaths.somethingWentWrongImage),
          );
        } else if (state is RacesSuccessState) {
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (!isLoading &&
                  scrollNotification is ScrollUpdateNotification &&
                  scrollNotification.metrics.extentAfter <=
                      MediaQuery.of(context).size.height * 0.05 &&
                  scrollNotification.metrics.axis == Axis.vertical &&
                  _cubit.racesList.length != _cubit.exploreList.length &&
                  _cubit.isTryingToFind == false) {
                setState(() {
                  isLoading = true;
                });
                Future.delayed(const Duration(seconds: 1)).then((value) {
                  _cubit.pagination();
                  _cubit.pageSize += 10;
                  setState(() {
                    isLoading = false;
                  });
                });
              }
              return false;
            },
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              slivers: _slivers(context, _cubit),
            ),
          );
        } else {
          //loading
          return const Center(
            child: LinearCircularProgressIndicator(
              isLinearProgressIndicator: false,
              color: AppColors.secondary,
              circularProgressWidth: Variables.double65,
              circularProgressHeight: Variables.double65,
              strokeWidth: Variables.five,
            ),
          );
        }
      },
    );
  }
}
