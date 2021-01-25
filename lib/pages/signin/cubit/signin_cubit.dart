import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _dbKey = 'user';
  String _tc;
  User _user;

  SigninCubit() : super(SigninInitial());

  Future<void> signin() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    try {
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      emit(SigninLoading());
      final UserCredential authResult = await _auth.signInWithCredential(credential);
      this._user = authResult.user;

      Future<DocumentSnapshot> snapshot = this._db.collection(this._dbKey).doc(this._user.email).get();
      await snapshot.then((value) {
        final Map data = value.data();
        bool isNewUser;
        data == null ? isNewUser = true : isNewUser = false;

        if (isNewUser)
          this._createFirestoreEntry();
        else
          this._loadFirestoreEntry(data);
      });
      emit(SigninLoaded());
    } catch (e) {
      emit(SigninError());
      this.signout();
    }
  }

  void _createFirestoreEntry() {
    this._tc = _createNewTc();
    DocumentReference ref = this._db.collection(this._dbKey).doc(this._user.email);
    ref.set({
      'email': this._user.email,
      'lastSeen': DateTime.now(),
      'tc': this._tc,
    });
    print("_createFirestoreEntry");
  }

  String _createNewTc() {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    String tc = databaseReference.push().key;
    return tc;
  }

  void _loadFirestoreEntry(Map data) {
    this._tc = data['tc'];
    print("_loadFirestoreEntry");
  }

  void signout() {
    this._auth.signOut();
    this._googleSignIn.signOut();
    emit(SigninInitial());
  }
}
