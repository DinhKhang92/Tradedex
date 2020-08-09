import 'package:firebase_database/firebase_database.dart';
import 'package:tradedex/Global/GlobalConstants.dart';

void deleteIndividualCollectionSingleListFirebase(String key, Profile myProfile) {
  FirebaseDatabase database = FirebaseDatabase.instance;

  database.reference().child(myProfile.id).child('individualCollection').child(key).remove();
}

void deleteIndividualCollectionFirebase(Profile myProfile) {
  FirebaseDatabase database = FirebaseDatabase.instance;

  database.reference().child(myProfile.id).child('individualCollection').remove();
}
