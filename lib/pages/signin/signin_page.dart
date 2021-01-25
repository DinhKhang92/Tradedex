import 'package:flutter/material.dart';
import 'package:tradedex/Global/Components/savaDataLocal.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:tradedex/localization/app_localization.dart';

import 'dart:async';

import 'package:tradedex/Global/Components/tos.dart';
import 'package:tradedex/Global/Components/tradedexLogo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/pages/signin/cubit/signin_cubit.dart';

class SignInPage extends StatefulWidget {
  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final String _logo = 'logo/tradedex_logo.png';
  // GlobalKey<FormState> formKey;
  // GlobalKey<ScaffoldState> scaffoldKey;
  // TextEditingController password;
  // Timer timer;

  // Profile myProfile;

  // bool absorbing;
  // bool autoValidate;

  // AuthService authService;

  // SignInPageState() {
  //   // this.myProfile = myProfile;
  //   this.absorbing = false;
  //   this.autoValidate = false;
  //   this.formKey = new GlobalKey<FormState>();
  //   this.scaffoldKey = new GlobalKey<ScaffoldState>();
  //   this.password = new TextEditingController();
  //   this.authService = new AuthService(this.myProfile);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(left: 40, right: 40),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height / 3.5),
                _buildLogo(),
                SizedBox(height: 40),
                _buildSignInButton(),
                SizedBox(height: 20),
                getTermsOfService(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 60.0,
        child: Image.asset(this._logo),
      ),
    );
  }

  Widget _buildSignInButton() {
    return InkWell(
      onTap: () => BlocProvider.of<SigninCubit>(context).signin(),
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        height: 40,
        width: 280,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]),
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(MdiIcons.google),
            Text(
              AppLocalizations.of(context).translate('PAGE_SIGN_IN.LOG_IN'),
              style: TextStyle(fontSize: 16),
            ),
            Icon(MdiIcons.google, color: Colors.transparent),
          ],
          // dense: true,
          // leading: Icon(MdiIcons.google),
          // title: Text(AppLocalizations.of(context).translate('PAGE_SIGN_IN.LOG_IN')),
          // onPressed: () {
          //   // setState(
          //   //   () {
          //   //     absorbing = true;
          //   //     this.authService.googleSignIn().then((value) {
          //   //       this.myProfile = this.authService.getProfile();
          //   //       saveIdLocal(this.myProfile.id);
          //   //       // Navigator.pushReplacement(
          //   //       //   context,
          //   //       //   MaterialPageRoute(
          //   //       //     builder: (context) => HomePage(),
          //   //       //   ),
          //   //       // );
          //   //     });
          //   //     saveInitLocal();
          //   //   },
          //   // );
          // },
          // color: Colors.white,
          // textColor: Colors.grey[800],
          // child: Row(
          //   children: <Widget>[
          //     Icon(MdiIcons.google),
          //     Text(AppLocalizations.of(context).translate('PAGE_SIGN_IN.LOG_IN')),
          //   ],
          // ),
        ),
      ),
    );
  }

  // Widget googleLoginButton() {
  //   return AbsorbPointer(
  //     absorbing: absorbing,
  //     child: StreamBuilder(
  //       stream: this.authService.user,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           return SizedBox(
  //             width: 240,
  //             child: MaterialButton(
  //               onPressed: () => this.authService.signOut(),
  //               color: buttonColor,
  //               textColor: buttonTextColor,
  //               child: Center(
  //                 child: Text(languageFile['PAGE_SIGN_IN']['SIGN_OUT']),
  //               ),
  //             ),
  //           );
  //         } else {
  //           return SizedBox(
  //             width: 240,
  //             child: MaterialButton(
  //               onPressed: () {
  //                 showProgressIndicator();
  //                 setState(
  //                   () {
  //                     absorbing = true;
  //                     this.authService.googleSignIn().then((value) {
  //                       this.myProfile = this.authService.getProfile();
  //                       saveIdLocal(this.myProfile.id);
  //                       // Navigator.pushReplacement(
  //                       //   context,
  //                       //   MaterialPageRoute(
  //                       //     builder: (context) => HomePage(),
  //                       //   ),
  //                       // );
  //                     });
  //                     saveInitLocal();
  //                   },
  //                 );
  //               },
  //               color: Colors.white,
  //               textColor: Colors.grey[800],
  //               child: Row(
  //                 children: <Widget>[
  //                   Icon(MdiIcons.google),
  //                   Text('\t \t \t \t ' + languageFile['PAGE_SIGN_IN']['LOG_IN']),
  //                 ],
  //               ),
  //             ),
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }

  // showProgressIndicator() {
  //   this.scaffoldKey.currentState.showSnackBar(
  //         new SnackBar(
  //           content: new Row(
  //             children: <Widget>[
  //               new CircularProgressIndicator(
  //                 valueColor: AlwaysStoppedAnimation<Color>(buttonColor),
  //               ),
  //               new Text(
  //                 '          ' + languageFile['PAGE_SIGN_IN']['SIGN_IN_LOADING'],
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  // }
}
