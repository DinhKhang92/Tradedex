import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  SigninCubit() : super(SigninInitial());

  Future<void> signin() async {
    print("-signin-");
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // print(credential);
    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    // print(authResult);
    // print(user);

    var me = this._auth.currentUser;
    print(me);
    print(" ");

    print(" ");
    // this._auth.signOut();
    this._googleSignIn.signOut();
    me = this._auth.currentUser;
    print(me);
  }
}
