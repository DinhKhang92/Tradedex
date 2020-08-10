import 'package:flutter/material.dart';
import 'package:tradedex/Global/Components/savaDataLocal.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'SignIn.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tradedex/Home/HomePage.dart';
import 'dart:async';

import 'package:tradedex/Global/Components/tos.dart';
import 'package:tradedex/Global/Components/tradedexLogo.dart';

class SignInPage extends StatefulWidget {
  final Profile myProfile;
  SignInPage(this.myProfile);

  @override
  SignInPageState createState() => new SignInPageState(this.myProfile);
}

class SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> formKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  TextEditingController password;
  Timer timer;

  Profile myProfile;

  bool absorbing;
  bool autoValidate;

  AuthService authService;

  SignInPageState(myProfile) {
    this.myProfile = myProfile;
    this.absorbing = false;
    this.autoValidate = false;
    this.formKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    this.password = new TextEditingController();
    this.authService = new AuthService(this.myProfile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this.scaffoldKey,
      backgroundColor: backgroundColor,
      body: Form(
        key: this.formKey,
        autovalidate: autoValidate,
        child: ListView(
          children: <Widget>[
            SafeArea(
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 150),
                    getHero(),
                    SizedBox(height: 30),
                    googleLoginButton(),
                    SizedBox(height: 30),
                    getTermsOfService(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget googleLoginButton() {
    return AbsorbPointer(
      absorbing: absorbing,
      child: StreamBuilder(
        stream: this.authService.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              width: 240,
              child: MaterialButton(
                onPressed: () => this.authService.signOut(),
                color: buttonColor,
                textColor: buttonTextColor,
                child: Center(
                  child: Text(languageFile['PAGE_SIGN_IN']['SIGN_OUT']),
                ),
              ),
            );
          } else {
            return SizedBox(
              width: 240,
              child: MaterialButton(
                onPressed: () {
                  showProgressIndicator();
                  setState(
                    () {
                      absorbing = true;
                      this.authService.googleSignIn().then((value) {
                        this.myProfile = this.authService.getProfile();
                        saveIdLocal(this.myProfile.id);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(myProfile),
                          ),
                        );
                      });
                      saveInitLocal();
                    },
                  );
                },
                color: Colors.white,
                textColor: Colors.grey[800],
                child: Row(
                  children: <Widget>[
                    Icon(MdiIcons.google),
                    Text('\t \t \t \t ' + languageFile['PAGE_SIGN_IN']['LOG_IN']),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  showProgressIndicator() {
    this.scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            content: new Row(
              children: <Widget>[
                new CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(buttonColor),
                ),
                new Text(
                  '          ' + languageFile['PAGE_SIGN_IN']['SIGN_IN_LOADING'],
                )
              ],
            ),
          ),
        );
  }
}
