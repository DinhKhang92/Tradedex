import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  String recentId;
  FirebaseDatabase _database = FirebaseDatabase.instance;
  ContactsCubit() : super(ContactsInitial());

  void setIdInput(String id) => this.recentId = id;

  void validateTradingCode(String id) {
    this._database.reference().child(id).once().then((snapshot) => print(snapshot.value));
  }

  void addContact() {
    this._database.reference().child('-M6S2PuTN1CH1IZUbcxDa').once().then((snapshot) => print(snapshot.value));
    // .child('-LpARDUIetmYbFdUTEsY')
    // .once()
    // .then((DataSnapshot snapshot) => print(snapshot.value));
  }

  // void addContact() {
  //   Contact newContact = new Contact();
  //   OfficialCollection officialCollection = new OfficialCollection();
  //   newContact.id = this.validId;

  //   database
  //       .reference()
  //       .child(newContact.id)
  //       .once()
  //       .then((DataSnapshot snapshot) {
  //     // account name
  //     if (snapshot.value['account_name'] != null)
  //       newContact.accountName = snapshot.value['account_name'];
  //     else
  //       newContact.accountName = languageFile['PAGE_CONTACTS']['INVALID_NAME'];

  //     // icon
  //     if (snapshot.value['icon'] != null)
  //       newContact.icon = snapshot.value['icon'];
  //     else
  //       newContact.icon = '001';

  //     // primary list
  //     if (snapshot.value['myMostWantedList'] != null &&
  //         snapshot.value['myMostWantedList'] != '[]')
  //       newContact.primaryList = snapshot.value['myMostWantedList']
  //           .toString()
  //           .replaceAll('[', '')
  //           .replaceAll(']', '')
  //           .replaceAll(' ', '')
  //           .split(',');
  //     else
  //       newContact.primaryList = new List<String>();

  //     // secondary list
  //     if (snapshot.value['myNeedList'] != null &&
  //         snapshot.value['myNeedList'] != '[]')
  //       newContact.secondaryList = snapshot.value['myNeedList']
  //           .toString()
  //           .replaceAll('[', '')
  //           .replaceAll(']', '')
  //           .replaceAll(' ', '')
  //           .split(',');
  //     else
  //       newContact.secondaryList = new List<String>();

  //     if (snapshot.value['officialCollection'] != null) {
  //       if (snapshot.value['officialCollection']['luckyList'] != null)
  //         officialCollection.luckyList = snapshot.value['officialCollection']
  //                 ['luckyList']
  //             .toString()
  //             .replaceAll('[', '')
  //             .replaceAll(']', '')
  //             .replaceAll(' ', '')
  //             .split(',');
  //       else
  //         officialCollection.luckyList = new List<String>();

  //       if (snapshot.value['officialCollection']['shinyList'] != null)
  //         officialCollection.shinyList = snapshot.value['officialCollection']
  //                 ['shinyList']
  //             .toString()
  //             .replaceAll('[', '')
  //             .replaceAll(']', '')
  //             .replaceAll(' ', '')
  //             .split(',');
  //       else
  //         officialCollection.shinyList = new List<String>();

  //       if (snapshot.value['officialCollection']['genderList']['maleList'] !=
  //           null)
  //         officialCollection.maleList = snapshot.value['officialCollection']
  //                 ['genderList']['maleList']
  //             .toString()
  //             .replaceAll('[', '')
  //             .replaceAll(']', '')
  //             .replaceAll(' ', '')
  //             .split(',');
  //       else
  //         officialCollection.maleList = new List<String>();

  //       if (snapshot.value['officialCollection']['genderList']['femaleList'] !=
  //           null)
  //         officialCollection.femaleList = snapshot.value['officialCollection']
  //                 ['genderList']['femaleList']
  //             .toString()
  //             .replaceAll('[', '')
  //             .replaceAll(']', '')
  //             .replaceAll(' ', '')
  //             .split(',');
  //       else
  //         officialCollection.femaleList = new List<String>();

  //       if (snapshot.value['officialCollection']['genderList']['neutralList'] !=
  //           null)
  //         officialCollection.neutralList = snapshot.value['officialCollection']
  //                 ['genderList']['neutralList']
  //             .toString()
  //             .replaceAll('[', '')
  //             .replaceAll(']', '')
  //             .replaceAll(' ', '')
  //             .split(',');
  //       else
  //         officialCollection.neutralList = new List<String>();
  //     }
}
