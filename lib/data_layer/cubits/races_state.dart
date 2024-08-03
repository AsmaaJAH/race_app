part of 'races_cubit.dart';

@immutable
abstract class RacesStates {}

final class RacesInitialState extends RacesStates {}

final class RacesLoadingState extends RacesStates {}

final class RacesSuccessState extends RacesStates {}

final class RacesFailureState extends RacesStates {}





