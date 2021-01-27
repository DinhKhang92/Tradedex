part of 'individual_cubit.dart';

@immutable
abstract class IndividualState {
  final String selectedValue;
  final Map collection;
  final Map typeMap;

  IndividualState({@required this.selectedValue, this.typeMap, this.collection});
}

class IndividualInitial extends IndividualState {
  final String selectedValue;
  final Map collection;
  final Map typeMap;
  IndividualInitial({
    @required this.selectedValue,
    @required this.collection,
    @required this.typeMap,
  });
}

class IndividualLoading extends IndividualState {
  final String selectedValue;
  final Map collection;
  final Map typeMap;
  IndividualLoading({
    @required this.selectedValue,
    @required this.collection,
    @required this.typeMap,
  });
}

class IndividualLoaded extends IndividualState {
  final String selectedValue;
  final Map collection;
  final Map typeMap;

  IndividualLoaded({
    @required this.selectedValue,
    @required this.collection,
    @required this.typeMap,
  });
}

class IndividualError extends IndividualState {}
