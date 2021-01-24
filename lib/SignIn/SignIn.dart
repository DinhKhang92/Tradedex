import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:tradedex/Global/Components/savaDataLocal.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:tradedex/Global/GlobalConstants.dart';

class AuthService with PropertyChangeNotifier<String> {
  // Dependencies
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final Firestore _db = Firestore.instance;

  // // Shared State for Widgets
  // Observable<FirebaseUser> user; // firebase user
  // Observable<Map<String, dynamic>> profile; // custom user data in Firestore
  // PublishSubject loading = PublishSubject();
  // bool isLoading;

  // // Variables
  // Profile myProfile;

  // // constructor
  // AuthService(myProfile) {
  //   this.myProfile = myProfile;

  //   user = Observable(_auth.onAuthStateChanged);

  //   profile = user.switchMap((FirebaseUser u) {
  //     if (u != null) {
  //       return _db.collection('users').document(u.uid).snapshots().map((snap) => snap.data);
  //     } else {
  //       return Observable.just({});
  //     }
  //   });
  // }

  // Future<FirebaseUser> googleSignIn() async {
  //   // Start
  //   loading.add(true);

  //   // Step 1
  //   GoogleSignInAccount googleUser = await _googleSignIn.signIn();

  //   // Step 2
  //   GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.getCredential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   FirebaseUser user = (await _auth.signInWithCredential(credential)).user;

  //   // Step 3
  //   await updateUserData(user);

  //   // Done
  //   loading.add(false);

  //   return user;
  // }

  // Future<void> updateUserData(FirebaseUser user) async {
  //   DocumentReference ref = _db.collection('users').document(user.uid);
  //   DocumentSnapshot snapshot = await ref.get();
  //   final databaseReference = FirebaseDatabase.instance.reference();
  //   final FirebaseDatabase database = FirebaseDatabase.instance;

  //   OfficialCollection myOfficialCollection = new OfficialCollection();

  //   if (!snapshot.exists) {
  //     this.myProfile.id = databaseReference.push().key;

  //     saveProfileFirebase(myProfile, myOfficialCollection);
  //     // saveIdLocal(this.myProfile.id);

  //     print("collection doesn't exist");
  //     return ref.setData({
  //       'email': user.email,
  //       'uid': user.uid,
  //       'displayName': user.displayName,
  //       'lastSeen': DateTime.now(),
  //       'myID': this.myProfile.id,
  //       'myAccountName': this.myProfile.accountName
  //     }, merge: true);
  //   } else {
  //     Future<DocumentSnapshot> document = Firestore.instance.collection('users').document(user.uid).get();
  //     await document.then((doc) {
  //       this.myProfile.id = doc.data['myID'];
  //       this.myProfile.accountName = doc.data['myAccountName'];
  //     });

  //     await database.reference().child(this.myProfile.id).once().then((DataSnapshot snapshot) {
  //       if (snapshot.value['account_name'] != null) this.myProfile.accountName = snapshot.value['account_name'];

  //       if (snapshot.value['myNeedList'] != null && snapshot.value['myNeedList'] != '[]')
  //         this.myProfile.secondaryList = snapshot.value['myNeedList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');

  //       if (snapshot.value['myMostWantedList'] != null && snapshot.value['myMostWantedList'] != '[]')
  //         this.myProfile.primaryList = snapshot.value['myMostWantedList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');

  //       if (snapshot.value['icon'] != null) {
  //         this.myProfile.icon = snapshot.value['icon'];
  //       }

  //       // saveIdLocal(this.myProfile.id);
  //     });

  //     print("collection exists.");
  //     return ref.updateData({'lastSeen': DateTime.now()});
  //   }
  // }

  // void signOut() {
  //   _auth.signOut();
  // }

  // Profile getProfile() {
  //   return this.myProfile;
  // }
}
