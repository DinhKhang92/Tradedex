import 'package:bloc/bloc.dart';
import 'package:tradedex/model/trainer.dart';
import 'package:meta/meta.dart';

import 'package:firebase_database/firebase_database.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> with Trainer {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  AccountCubit() : super(AccountState(tc: '', icon: '001', name: ''));

  void setTc(String tc) {
    Trainer.tc = tc;
    emit(AccountState(tc: Trainer.tc, icon: state.icon, name: state.name));
  }

  void setIcon(String icon) {
    Trainer.icon = icon;
    emit(AccountState(tc: state.tc, icon: icon, name: state.name));
  }

  void setName(String name) {
    Trainer.name = name;
    emit(AccountState(tc: state.tc, icon: state.icon, name: name));
  }

  void initDatebase() {
    this._database.reference().child(Trainer.tc).set({
      'name': state.name,
      'icon': state.icon,
      'pokemon': {
        'primary': {},
        'secondary': {},
        'official': {
          'lucky': {},
          'shiny': {},
          'gender': {},
        },
        'individual': {},
      }
    });
  }
}
