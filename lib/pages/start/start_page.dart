import 'package:flutter/material.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tradedex/cubit/localization_cubit.dart';
import 'package:tradedex/cubit/account_cubit.dart';

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
        backgroundColor: Color(0xff242423),
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 40, right: 40),
          children: <Widget>[
            // _buildLogo(),
            SizedBox(height: MediaQuery.of(context).size.height / 4),
            _buildIcon(),
            SizedBox(height: 48.0),
            _buildNameInput(),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          shape: BoxShape.circle,
          border: Border.all(
            width: 1.5,
            color: Colors.white.withOpacity(0.25),
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Image(
                image: AssetImage('assets_bundle/pokemon_icons_blank/001.png'),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: Color(0xffee6c4d),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.edit,
                  size: 16,
                ),
              ),
            ),
          ],
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
        cursorColor: Colors.white,
      ),
      child: Form(
        key: this._formKey,
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          validator: (name) => _validateName(name),
          onChanged: (name) => BlocProvider.of<AccountCubit>(context).setName(name),
          autofocus: false,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.25),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white.withOpacity(0.25),
              ),
              borderRadius: BorderRadius.circular(32.0),
            ),
            hintText: AppLocalizations.of(context).translate('PAGE_START.ENTER_TRAINER_NAME'),
            hintStyle: TextStyle(color: Colors.white),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white.withOpacity(0.25),
              ),
              borderRadius: BorderRadius.circular(32.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white.withOpacity(0.25),
              ),
              borderRadius: BorderRadius.circular(32.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white.withOpacity(0.25),
              ),
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        ),
      ),
    );
  }

  String _validateName(String name) {
    return name.isEmpty ? AppLocalizations.of(context).translate('PAGE_START.ENTER_TRAINER_NAME_VALIDATION') : null;
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () => this._continue(),
        padding: EdgeInsets.all(12),
        color: Color(0xffee6c4d),
        child: Text(
          AppLocalizations.of(context).translate('PAGE_START.CONTINUE'),
        ),
      ),
    );
  }

  bool _checkIfNameIsValid() {
    return this._formKey.currentState.validate();
  }

  void _continue() {
    bool isValidName = _checkIfNameIsValid();
    if (isValidName) {
      BlocProvider.of<AccountCubit>(context).initDatebase();
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }
}
