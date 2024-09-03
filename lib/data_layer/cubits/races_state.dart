part of 'races_cubit.dart';

@immutable //instances cannot be modified after creation
abstract class RacesStates {}

final class RacesInitialState extends RacesStates {}

final class RacesLoadingState extends RacesStates {}

final class RacesSuccessState extends RacesStates {}

final class RacesFailureState extends RacesStates {}
