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

import 'package:tradedex/cubit/account_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInPage extends StatefulWidget {
  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final String _logo = 'logo/tradedex_logo.png';
  final String _urlPp = 'https://github.com/DinhKhang92/Tradedex/blob/master/Privacy_Policy.md';
  final String _urlToS = 'https://github.com/DinhKhang92/Tradedex/blob/master/Terms_of_Service.md';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height / 3.5),
              _buildLogo(),
              SizedBox(height: 40),
              _buildSignin(),
              SizedBox(height: 20),
              _buildToS(),
              Spacer(),
              _buildContinue(),
            ],
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

  Widget _buildSignin() {
    return BlocBuilder<SigninCubit, SigninState>(
      builder: (context, state) {
        print(state);
        if (state is SigninInitial)
          return _buildSigninInitial();
        else if (state is SigninLoading)
          return _buildSigninLoading();
        else if (state is SigninLoaded)
          return _buildSigninLoaded();
        else if (state is SigninError)
          return _buildSigninError();
        else
          return Container();
      },
    );
  }

  Widget _buildSigninInitial() {
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
              offset: Offset(2, 2),
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
        ),
      ),
    );
  }

  Widget _buildSigninLoading() {
    return CircularProgressIndicator();
  }

  Widget _buildSigninLoaded() {
    return BlocBuilder<SigninCubit, SigninState>(
      builder: (context, state) {
        BlocProvider.of<AccountCubit>(context).setTc(state.tc);
        return InkWell(
          onTap: () => BlocProvider.of<SigninCubit>(context).signout(),
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
                  AppLocalizations.of(context).translate('PAGE_SIGN_IN.LOG_OUT'),
                  style: TextStyle(fontSize: 16),
                ),
                Icon(MdiIcons.google, color: Colors.transparent),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSigninError() {
    return Text("ERROR");
  }

  Widget _buildToS() {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: AppLocalizations.of(context).translate('PAGE_START.TOS_AND_PRIVACY_TEXT_1'),
            style: TextStyle(color: textColor),
            children: <TextSpan>[
              TextSpan(
                style: TextStyle(color: urlColor),
                text: AppLocalizations.of(context).translate('PAGE_START.TOS'),
                recognizer: TapGestureRecognizer()..onTap = () => _url(this._urlToS),
              ),
              TextSpan(text: AppLocalizations.of(context).translate('PAGE_START.TOS_AND_PRIVACY_TEXT_2')),
              TextSpan(
                style: TextStyle(color: urlColor),
                text: AppLocalizations.of(context).translate('PAGE_START.PRIVACY'),
                recognizer: TapGestureRecognizer()..onTap = () => _url(this._urlPp),
              ),
              TextSpan(text: AppLocalizations.of(context).translate('PAGE_START.TOS_AND_PRIVACY_TEXT_3')),
            ],
          ),
        ),
      ),
    );
  }

  void _url(String url) async {
    if (await canLaunch(url)) await launch(url);
  }

  Widget _buildContinue() {
    return BlocBuilder<SigninCubit, SigninState>(
      builder: (context, state) {
        if (state is SigninLoaded) return _buildContinueLoaded();
        return _buildContinueLoading();
      },
    );
  }

  Widget _buildContinueLoaded() {
    return Align(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => Navigator.of(context).pushNamed('/start'),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(AppLocalizations.of(context).translate('PAGE_START.CONTINUE')),
            Icon(Icons.arrow_right),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueLoading() {
    return Align(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => {},
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).translate('PAGE_START.CONTINUE'),
              style: TextStyle(color: Colors.black38),
            ),
            Icon(
              Icons.arrow_right,
              color: Colors.black38,
            ),
          ],
        ),
      ),
    );
  }
}
