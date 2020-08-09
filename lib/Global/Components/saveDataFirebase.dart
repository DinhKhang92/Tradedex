import 'package:firebase_database/firebase_database.dart';
import 'package:tradedex/Global/GlobalConstants.dart';

void saveProfileFirebase(Profile myProfile, OfficialCollection myOfficialCollection) {
  FirebaseDatabase database = FirebaseDatabase.instance;

  database.reference().child(myProfile.id).set({
    'account_name': myProfile.accountName,
    'id': myProfile.id,
    'myMostWantedList': myProfile.primaryList.toString(),
    'myNeedList': myProfile.secondaryList.toString(),
    'icon': myProfile.icon,
    'officialCollection': {
      'luckyList': myOfficialCollection.luckyList.toString(),
      'shinyList': myOfficialCollection.shinyList.toString(),
      'genderList': {
        'maleList': myOfficialCollection.maleList.toString(),
        'femaleList': myOfficialCollection.femaleList.toString(),
        'neutralList': myOfficialCollection.neutralList.toString()
      }
    }
  });
}

void savePokemonListsFirebase(Profile myProfile) {
  FirebaseDatabase database = FirebaseDatabase.instance;

  database.reference().child(myProfile.id).update({
    'myMostWantedList': myProfile.primaryList.toString(),
    'myNeedList': myProfile.secondaryList.toString(),
  });
}

void saveAccountNameFirebase(Profile myProfile) {
  FirebaseDatabase database = FirebaseDatabase.instance;

  database.reference().child(myProfile.id).update({
    'account_name': myProfile.accountName,
  });
}

void saveIconFirebase(Profile myProfile) {
  FirebaseDatabase database = FirebaseDatabase.instance;

  database.reference().child(myProfile.id).update({
    'icon': myProfile.icon,
  });
}

void saveIndividualCollectionFirebase(Map myIndividualCollection, Profile myProfile) {
  FirebaseDatabase database = FirebaseDatabase.instance;

  for (int i = 0; i < myIndividualCollection.keys.length; i++) {
    String key = myIndividualCollection.keys.toList()[i];
    database.reference().child(myProfile.id).child('individualCollection').update({
      key: {
        'listType': myIndividualCollection[key]['listType'],
        'list': myIndividualCollection[key]['list'],
      },
    });
  }
}

void saveIndividualCollectionSingleListFirebase(List<String> myIndividualCollectionSingleList, Profile myProfile, String key, String listType) {
  FirebaseDatabase database = FirebaseDatabase.instance;

  database.reference().child(myProfile.id).child('individualCollection').child(key).update({
    'listType': listType,
    'list': myIndividualCollectionSingleList.toString(),
  });
}

void saveOfficialCollectionFirebase(OfficialCollection myOfficialCollection, Profile myProfile) {
  FirebaseDatabase database = FirebaseDatabase.instance;

  database.reference().child(myProfile.id).update({
    'officialCollection': {
      'luckyList': myOfficialCollection.luckyList.toString(),
      'shinyList': myOfficialCollection.shinyList.toString(),
      'genderList': {
        'maleList': myOfficialCollection.maleList.toString(),
        'femaleList': myOfficialCollection.femaleList.toString(),
        'neutralList': myOfficialCollection.neutralList.toString()
      }
    }
  });
}

void saveContactsFirebase(List<Contact> myContacts, Profile myProfile) {
  FirebaseDatabase database = FirebaseDatabase.instance;
  List<String> myContactsIds = new List<String>();

  myContacts.forEach((contact) => myContactsIds.add(contact.id));

  database.reference().child(myProfile.id).update({
    'myFriends': myContactsIds,
  });
}
