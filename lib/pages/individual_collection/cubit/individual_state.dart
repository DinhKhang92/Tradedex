part of 'individual_cubit.dart';

@immutable
abstract class IndividualState {
  final List<DropdownMenuItem<String>> dropdownList;
  final String dropdownValue;
  final Map collection;

  IndividualState({@required this.dropdownValue, this.dropdownList, this.collection});
}

class IndividualInitial extends IndividualState {
  final String dropdownValue;
  final Map collection;
  IndividualInitial({
    @required this.dropdownValue,
    @required this.collection,
  });
}

class IndividualLoading extends IndividualState {
  final String dropdownValue;
  final Map collection;
  IndividualLoading({
    @required this.dropdownValue,
    @required this.collection,
  });
}

class IndividualLoaded extends IndividualState {
  final List<DropdownMenuItem<String>> dropdownList;
  final String dropdownValue;
  final Map collection;

  IndividualLoaded({
    @required this.dropdownValue,
    @required this.dropdownList,
    @required this.collection,
  });
}

class IndividualError extends IndividualState {}
