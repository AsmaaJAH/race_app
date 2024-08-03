part of 'visibility_cubit.dart';

@immutable
abstract class VisibilityStates {}

final class VisibilityInitialState extends VisibilityStates {}

final class VisibleNavBarState extends VisibilityStates {}

final class HiddenNavBarState extends VisibilityStates {}
