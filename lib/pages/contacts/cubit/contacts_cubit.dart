import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  Map contacts = new Map();
  ContactsCubit() : super(ContactsInitial(contacts: {}));

  void addContact(String id) {
    // print("-addContact-");
    // this._database.reference().child(id).once().then((snapshot) {
    //   print(snapshot.value);
    //   if (snapshot.value != null) {
    //     print(json.decode(snapshot.value['myMostWantedList']));
    //   } else
    //     print("null!");
    // });

    this._database.reference().child(id).update({
      'test2': {'hello': 'world'},
    });
  }
}
