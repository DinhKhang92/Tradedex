import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
part 'individual_state.dart';

enum Individual {
  Alolan,
  Event,
  Galar,
  Regional,
  Pokedex,
  Shadow,
  Spinda,
  Unown,
}

class IndividualCubit extends Cubit<IndividualState> {
  BuildContext context;

  List<DropdownMenuItem<String>> dropdownMenuItems = List<DropdownMenuItem<String>>();

  IndividualCubit() : super(IndividualInitial(dropdownValue: ''));

  void loadDropdownList(Map dropdownMap) {
    emit(IndividualLoading(dropdownValue: state.dropdownValue));

    this.dropdownMenuItems = List<DropdownMenuItem<String>>();
    for (String elem in dropdownMap.values) {
      this.dropdownMenuItems.add(DropdownMenuItem(value: elem, child: Text(elem)));
    }

    emit(IndividualLoaded(
      dropdownValue: dropdownMap.values.first,
      dropdownList: this.dropdownMenuItems,
    ));
  }

  void setDropdownValue(String val) => emit(IndividualLoaded(dropdownValue: val, dropdownList: state.dropdownList));
}
