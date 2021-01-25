import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tradedex/cubit/localization_cubit.dart';

class StartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String _logo = 'logo/tradedex_logo.png';
  final String _urlPp = 'https://github.com/DinhKhang92/Tradedex/blob/master/Privacy_Policy.md';
  final String _urlToS = 'https://github.com/DinhKhang92/Tradedex/blob/master/Terms_of_Service.md';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              _buildLogo(),
              SizedBox(height: 48.0),
              _buildNameInput(),
              _buildContinueButton(),
              _buildToS(),
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

  Widget _buildNameInput() {
    return Theme(
      data: ThemeData(
        hintColor: subTextColor,
        cursorColor: buttonColor,
      ),
      child: Form(
        key: this._formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              style: TextStyle(color: textColor),
              validator: (name) => _validateName(name),
              autofocus: false,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBorderColor),
                  borderRadius: BorderRadius.circular(32.0),
                ),
                hintText: AppLocalizations.of(context).translate('PAGE_START.ENTER_TRAINER_NAME'),
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBorderColor),
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _validateName(String name) {
    return name.isEmpty ? AppLocalizations.of(context).translate('PAGE_START.ENTER_TRAINER_NAME_VALIDATION') : null;
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          bool isValidName = _checkIfNameIsValid();
          if (isValidName) Navigator.of(context).pushReplacementNamed('/signin');
        },
        padding: EdgeInsets.all(12),
        color: buttonColor,
        child: Text(
          AppLocalizations.of(context).translate('PAGE_START.CONTINUE'),
          style: TextStyle(color: backgroundColor),
        ),
      ),
    );
  }

  bool _checkIfNameIsValid() {
    return this._formKey.currentState.validate();
  }

  Widget _buildToS() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: AppLocalizations.of(context).translate('PAGE_START.TOS_AND_PRIVACY_TEXT_1'),
          style: TextStyle(color: textColor),
          children: <TextSpan>[
            TextSpan(
                style: TextStyle(
                  color: urlColor,
                ),
                text: AppLocalizations.of(context).translate('PAGE_START.TOS'),
                recognizer: TapGestureRecognizer()..onTap = () => _url(this._urlToS)),
            TextSpan(
              text: AppLocalizations.of(context).translate('PAGE_START.TOS_AND_PRIVACY_TEXT_2'),
            ),
            TextSpan(
                style: TextStyle(
                  color: urlColor,
                ),
                text: AppLocalizations.of(context).translate('PAGE_START.PRIVACY'),
                recognizer: TapGestureRecognizer()..onTap = () => _url(this._urlPp)),
            TextSpan(
              text: AppLocalizations.of(context).translate('PAGE_START.TOS_AND_PRIVACY_TEXT_3'),
            ),
          ],
        ),
      ),
    );
  }

  void _url(String url) async {
    if (await canLaunch(url)) await launch(url);
  }
}
