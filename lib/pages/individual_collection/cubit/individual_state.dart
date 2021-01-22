part of 'individual_cubit.dart';

@immutable
abstract class IndividualState {}

class IndividualInitial extends IndividualState {}

class IndividualLoading extends IndividualState {}

class IndividualLoaded extends IndividualState {}

class IndividualError extends IndividualState {}
