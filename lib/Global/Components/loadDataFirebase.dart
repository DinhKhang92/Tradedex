import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'dart:async';

Future<Profile> loadProfile() async {
  Profile myProfile = new Profile();
  FirebaseDatabase database = FirebaseDatabase.instance;
  SharedPreferences prefs = await SharedPreferences.getInstance();

  myProfile.accountName = 'Trainer xy';
  myProfile.id = prefs.getString('myID') ?? '-1';
  myProfile.primaryList = new List<String>();
  myProfile.secondaryList = new List<String>();
  myProfile.icon = '123';

  if (myProfile.id.length == 20) {
    await database.reference().child(myProfile.id).once().then((DataSnapshot snapshot) {
      // load account name
      if (snapshot.value['account_name'] != null)
        myProfile.accountName = snapshot.value['account_name'];
      else
        myProfile.accountName = languageFile['PAGE_CONTACTS']['INVALID_NAME'];

      // load primary list
      if (snapshot.value['myMostWantedList'] != null)
        myProfile.primaryList = snapshot.value['myMostWantedList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
      else
        myProfile.primaryList = new List<String>();

      // load secondary list
      if (snapshot.value['myMostWantedList'] != null)
        myProfile.secondaryList = snapshot.value['myNeedList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
      else
        myProfile.secondaryList = new List<String>();

      // load icon
      if (snapshot.value['icon'] != null)
        myProfile.icon = snapshot.value['icon'];
      else
        myProfile.icon = '001';
    });
  }
  return myProfile;
}

Future<List<Contact>> loadContactsFirebase(Profile myProfile) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  List<Contact> myContacts = new List<Contact>();
  List<dynamic> ids = List<String>();

  await database.reference().child(myProfile.id).child('myFriends').once().then((DataSnapshot contactIds) {
    if (contactIds.value != null) ids = contactIds.value;
  });

  for (int i = 0; i < ids.length; i++) {
    await database.reference().child(ids[i]).once().then((DataSnapshot snapshot) {
      Contact contact = new Contact();
      OfficialCollection officialCollection = new OfficialCollection();

      // load account name
      if (snapshot.value['account_name'] != null)
        contact.accountName = snapshot.value['account_name'];
      else
        contact.accountName = languageFile['PAGE_CONTACTS']['INVALID_NAME'];

      // load id
      if (snapshot.value['id'] != null)
        contact.id = snapshot.value['id'];
      else
        contact.id = '-1';

      // load primary list
      if (snapshot.value['myMostWantedList'] != null)
        contact.primaryList = snapshot.value['myMostWantedList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
      else
        contact.primaryList = new List<String>();

      // load secondary list
      if (snapshot.value['myMostWantedList'] != null)
        contact.secondaryList = snapshot.value['myNeedList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
      else
        contact.secondaryList = new List<String>();

      // load icon
      if (snapshot.value['icon'] != null)
        contact.icon = snapshot.value['icon'];
      else
        contact.icon = '001';

      if (snapshot.value['officialCollection'] != null) {
        if (snapshot.value['officialCollection']['luckyList'] != null)
          officialCollection.luckyList = snapshot.value['officialCollection']['luckyList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
        else
          officialCollection.luckyList = new List<String>();

        if (snapshot.value['officialCollection']['shinyList'] != null)
          officialCollection.shinyList = snapshot.value['officialCollection']['shinyList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
        else
          officialCollection.shinyList = new List<String>();

        if (snapshot.value['officialCollection']['genderList']['maleList'] != null)
          officialCollection.maleList =
              snapshot.value['officialCollection']['genderList']['maleList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
        else
          officialCollection.maleList = new List<String>();

        if (snapshot.value['officialCollection']['genderList']['femaleList'] != null)
          officialCollection.femaleList =
              snapshot.value['officialCollection']['genderList']['femaleList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
        else
          officialCollection.femaleList = new List<String>();

        if (snapshot.value['officialCollection']['genderList']['neutralList'] != null)
          officialCollection.neutralList =
              snapshot.value['officialCollection']['genderList']['neutralList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
        else
          officialCollection.neutralList = new List<String>();
      }

      print(officialCollection.luckyList);
      print(officialCollection.shinyList);
      print(officialCollection.maleList);

      contact.officialCollection = officialCollection;

      myContacts.add(contact);
    });
  }
  return myContacts;
}

Future<OfficialCollection> loadOfficialCollectionFirebase(Profile myProfile) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  OfficialCollection myOfficialCollection = new OfficialCollection();

  await database.reference().child(myProfile.id).child('officialCollection').once().then((DataSnapshot snapshot) {
    if (snapshot.value != null) {
      // lucky list
      if (snapshot.value['luckyList'] == null || snapshot.value['luckyList'] == '[]')
        myOfficialCollection.luckyList = new List<String>();
      else
        myOfficialCollection.luckyList = snapshot.value['luckyList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');

      // shiny list
      if (snapshot.value['shinyList'] == null || snapshot.value['shinyList'] == '[]')
        myOfficialCollection.shinyList = new List<String>();
      else
        myOfficialCollection.shinyList = snapshot.value['shinyList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');

      // male list
      if (snapshot.value['genderList']['maleList'] == null || snapshot.value['genderList']['maleList'] == '[]')
        myOfficialCollection.maleList = new List<String>();
      else
        myOfficialCollection.maleList = snapshot.value['genderList']['maleList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');

      // female list
      if (snapshot.value['genderList']['femaleList'] == null || snapshot.value['genderList']['femaleList'] == '[]')
        myOfficialCollection.femaleList = new List<String>();
      else
        myOfficialCollection.femaleList = snapshot.value['genderList']['femaleList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');

      // neutral list
      if (snapshot.value['genderList']['neutralList'] == null || snapshot.value['genderList']['neutralList'] == '[]')
        myOfficialCollection.neutralList = new List<String>();
      else
        myOfficialCollection.neutralList = snapshot.value['genderList']['neutralList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
    }
  });
  return myOfficialCollection;
}

Future<Map> loadIndividualCollectionFirebase(Profile myProfile) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  Map myIndividualCollection = new Map();

  await database.reference().child(myProfile.id).child('individualCollection').once().then((DataSnapshot snapshot) {
    if (snapshot.value != null) {
      snapshot.value.keys.toList().forEach((key) {
        if (snapshot.value[key]['list'] == null || snapshot.value[key]['list'] == '[]') {
          myIndividualCollection[key] = {
            'listType': snapshot.value[key]['listType'],
            'list': new List<String>(),
          };
        } else {
          myIndividualCollection[key] = {
            'listType': snapshot.value[key]['listType'],
            'list': snapshot.value[key]['list'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(','),
          };
        }
      });
    }
  });

  return myIndividualCollection;
}
