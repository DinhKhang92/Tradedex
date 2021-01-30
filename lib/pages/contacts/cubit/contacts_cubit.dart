import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final List<String> _contactList = new List<String>();
  Map _contacts = new Map();
  ContactsCubit() : super(ContactsInitial(contacts: {}, navIdx: 0));

  void setNavIdx(int idx) => emit(ContactsLoaded(
        contacts: state.contacts,
        navIdx: idx,
      ));

  void addContact(String tc) {
    emit(ContactsLoading(contacts: state.contacts, navIdx: state.navIdx));
    this._database.reference().child(tc).once().then((snapshot) {
      print(snapshot.value);
      if (snapshot.value != null) {
        bool isNewContact = !this._contactList.contains(tc);
        if (isNewContact) {
          this._contactList.add(tc);
          _addContactToDatabase(tc);
        }
      } else {
        print("null!");
      }
      this._contacts[tc] = {};
      this._contacts[tc]['name'] = snapshot.value['name'];
      this._contacts[tc]['icon'] = snapshot.value['icon'];
      this._contacts[tc]['pokemon'] = snapshot.value['pokemon'] ?? {};

      print("contacts: ");
      print(this._contacts);

      emit(ContactsLoaded(contacts: this._contacts, navIdx: state.navIdx));
    });
  }

  void _addContactToDatabase(String tc) {
    this._database.reference().child(tc).update({
      'contacts': this._contactList,
    });
  }

  void deleteContact(String tc) {
    this._contacts.remove(tc);
    emit(ContactsLoaded(contacts: this._contacts, navIdx: state.navIdx));
  }

  void dispose() {
    this.close();
  }
}
