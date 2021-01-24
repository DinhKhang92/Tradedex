import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_database/firebase_database.dart';

part 'trading_code_state.dart';

class TradingCodeCubit extends Cubit<TradingCodeState> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  TradingCodeCubit() : super(TradingCodeInitial(valid: false));

  String validateTradingCode(String id) {
    this._database.reference().child(id).once().then((snapshot) {
      print(snapshot.value);
      if (snapshot.value == null)
        return "ERROR";
      else
        return ("YAY");
    });
    // return 'blubb';
  }
}
