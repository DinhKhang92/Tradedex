part of 'individual_cubit.dart';

@immutable
abstract class IndividualState {
  final List<DropdownMenuItem<String>> dropdownList;
  final String dropdownValue;

  IndividualState({@required this.dropdownValue, this.dropdownList});
}

class IndividualInitial extends IndividualState {
  final String dropdownValue;
  IndividualInitial({
    @required this.dropdownValue,
  });
}

class IndividualLoading extends IndividualState {
  final String dropdownValue;
  IndividualLoading({
    @required this.dropdownValue,
  });
}

class IndividualLoaded extends IndividualState {
  final List<DropdownMenuItem<String>> dropdownList;
  final String dropdownValue;

  IndividualLoaded({
    @required this.dropdownValue,
    @required this.dropdownList,
  });
}

class IndividualError extends IndividualState {}
