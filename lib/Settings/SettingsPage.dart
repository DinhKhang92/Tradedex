import 'package:flutter/material.dart';
import 'package:tradedex/Global/Components/loadDataLocal.dart';
import 'package:tradedex/Global/Components/savaDataLocal.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';
import 'package:tradedex/Global/Components/setColorTheme.dart';
import './Components/getPokemonImage.dart';
import 'package:tradedex/Settings/Components/showAboutSubtitle.dart';
import 'package:tradedex/Settings/Components/showDataPolicy.dart';
import 'package:tradedex/Settings/Components/showTermsOfUse.dart';
import 'Components/showAbout.dart';
import 'package:tradedex/Settings/Components/showDivider.dart';
import 'package:tradedex/Settings/Components/showProfile.dart';
import 'package:tradedex/Settings/Components/showProfileSubtitle.dart';
import 'package:tradedex/Settings/Components/showReport.dart';
import 'package:tradedex/Settings/Components/showTradedex.dart';
import 'package:tradedex/Settings/Components/showTradedexSubtitle.dart';
import 'package:tradedex/Settings/Components/showSupport.dart';
import 'Components/showSupportSubtitle.dart';
import '../Global/GlobalConstants.dart';

import 'dart:convert';
import 'package:flutter/services.dart';

class SettingsPage extends StatefulWidget {
  final Profile myProfile;
  final List<dynamic> pokemonNamesDictKeys;

  SettingsPage(this.myProfile, this.pokemonNamesDictKeys);

  @override
  State<StatefulWidget> createState() {
    return SettingsPageState(this.myProfile, this.pokemonNamesDictKeys);
  }
}

class SettingsPageState extends State<SettingsPage> {
  GlobalKey<ScaffoldState> scaffoldKey;
  Profile myProfile;
  List<dynamic> pokemonNamesDictKeys;
  TextEditingController textController;

  bool darkTheme = false;

  SettingsPageState(myProfile, pokemonNamesDictKeys) {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    this.myProfile = myProfile;
    this.pokemonNamesDictKeys = pokemonNamesDictKeys;

    this.textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this.scaffoldKey,
      appBar: AppBar(
        title: Text(
          languageFile['PAGE_SETTINGS']['TITLE'],
          style: TextStyle(color: titleColor),
        ),
        backgroundColor: appBarColor,
      ),
      body: settingsPageBoy(context),
    );
  }

  Widget showColorTheme(context) {
    return Container(
      color: backgroundColor,
      child: ListTile(
        trailing: Switch(
          activeColor: buttonColor,
          value: this.darkTheme,
          onChanged: (bool choice) {
            setState(() {
              this.darkTheme = choice;
              setColorTheme(this.darkTheme);
            });
            saveColorThemeLocal(this.darkTheme);
          },
        ),
        title: Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: languageFile['PAGE_SETTINGS']['DARK_THEME_TITLE'],
                style: TextStyle(
                  fontSize: 15.0,
                  color: textColor,
                ),
              ),
              TextSpan(
                text: '\n' + languageFile['PAGE_SETTINGS']['DARK_THEME_DESCRIPTION'],
                style: TextStyle(
                  fontSize: 12.0,
                  height: 1.3,
                  color: subTextColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget settingsPageBoy(context) {
    return FutureBuilder(
      future: loadColorTheme(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
            color: backgroundColor,
          );
        } else {
          this.darkTheme = snapshot.data;
          return ListView(
            children: <Widget>[
              showProfileSubtitle(),
              showProfile(this.myProfile, context, changeAccountName, changeIcon, getPokemonImage),
              showDivider(),
              showTradedexSubtitle(),
              showTradedex(changeLanguage),
              showColorTheme(context),
              showDivider(),
              showSupportSubtitle(),
              showSupport(context),
              showReport(),
              showDivider(),
              showAboutSubtitle(),
              showAbout(context),
              showDataPolicy(),
              showTermsOfUse()
            ],
          );
        }
      },
    );
  }

  void loadLanguage(String selected) async {
    selectedLanguage = selected;
    if (selected == 'en')
      rootBundle.loadString("json/languages/en.json").then((String file) {
        setState(() {
          languageFile = json.decode(file);
        });
      });
    else
      rootBundle.loadString("json/languages/de.json").then((String file) {
        setState(() {
          languageFile = json.decode(file);
        });
      });
  }

  void changeLanguage() async {
    int languageValue = 0;
    if (selectedLanguage == 'de') {
      languageValue = 1;
    }
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          title: Text(
            languageFile['PAGE_SETTINGS']['DIALOG_LANGUAGE']['SELECT_LANGUAGE_TITLE'],
            style: TextStyle(color: textColor),
          ),
          content: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Theme(
                    data: Theme.of(context).copyWith(unselectedWidgetColor: subTextColor),
                    child: Radio(
                      value: 0,
                      activeColor: buttonColor,
                      groupValue: languageValue,
                      onChanged: (int value) {
                        loadLanguage('en');
                        saveLanguageLocal('en');
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Text(
                    languageFile['LANGUAGES']['ENGLISH'],
                    style: TextStyle(color: textColor),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Theme(
                    data: Theme.of(context).copyWith(unselectedWidgetColor: subTextColor),
                    child: Radio(
                      value: 1,
                      activeColor: buttonColor,
                      groupValue: languageValue,
                      onChanged: (int value) {
                        loadLanguage('de');
                        saveLanguageLocal('de');
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Text(
                    languageFile['LANGUAGES']['GERMAN'],
                    style: TextStyle(color: textColor),
                  )
                ],
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                languageFile['PAGE_SETTINGS']['DIALOG_LANGUAGE']['CLOSE'],
                style: TextStyle(color: buttonColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void changeAccountName(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: backgroundColor,
        contentPadding: const EdgeInsets.all(18.0),
        content: Row(
          children: <Widget>[
            Form(
              child: Expanded(
                child: TextFormField(
                  style: TextStyle(color: textColor),
                  onFieldSubmitted: (String newAccountName) {
                    this.myProfile.accountName = newAccountName;
                    saveAccountNameFirebase(myProfile);
                    Navigator.pop(context);
                  },
                  controller: textController,
                  autofocus: true,
                  cursorColor: buttonColor,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: textColor),
                    ),
                    labelText: languageFile['PAGE_SETTINGS']['YOUR_NEW_TRAINER_NAME'],
                    labelStyle: TextStyle(color: textColor),
                    hintText: languageFile['PAGE_SETTINGS']['TRAINER_XY'],
                    hintStyle: TextStyle(color: prefillTextColor),
                  ),
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: buttonColor,
              child: IconButton(
                icon: Icon(
                  Icons.send,
                  color: buttonTextColor,
                ),
                color: iconColor,
                onPressed: () {
                  this.myProfile.accountName = this.textController.text;
                  // _saveMyAccountName();
                  saveAccountNameFirebase(myProfile);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeIcon() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: dialogBackgroundColor,
          title: Text(
            languageFile['PAGE_SETTINGS']['CHOOSE_ICON'],
            style: TextStyle(color: textColor),
          ),
          content: Container(
            width: 150,
            child: GridView.builder(
              itemCount: this.pokemonNamesDictKeys.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
              itemBuilder: (context, i) {
                String idx = this.pokemonNamesDictKeys[i];
                return GridTile(
                  child: InkResponse(
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: new BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: getPokemonImage(idx),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        this.myProfile.icon = idx;
                      });
                      // _saveMyIcon();
                      // _updateFireBase();
                      saveIconFirebase(myProfile);
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

//   void _saveMyAccountName() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('myAccountName', myAccountName);
//   }

//   void _updateFireBase() {
//     database.reference().child(myID).update({
//       'icon': prefix0.myIcon,
//       'account_name': myAccountName,
//     });
//   }

//   void _saveMyIcon() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('icon', prefix0.myIcon);
//   }

//   void _saveMyTheme() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('theme', prefix0.myClassicTheme);
//   }

//   void _changeTheme(bool choice) {
//     myClassicTheme = !myClassicTheme;
//     if (myClassicTheme == false)
//       _setClassicTheme();
//     else
//       _setDarkTheme();
//   }

//   _setDarkTheme() {
//     redColor = Colors.grey[800];
//     listTileColor = Colors.black87;
//     textColor = Colors.white;
//     markBorderColor = Colors.white70;
//     markPokemonColor = Colors.red[900];
//     subTextColor = Colors.white54;
//     captionTextColor = Colors.white54;
//     dividerColor = Colors.grey[600];
//     buttonColor = Colors.grey[600];
//     iconColor = Colors.white;
//     drawerColor = Colors.black87;
//     backgroundColor = Colors.black87;
//     bottomNavBarColor = Colors.grey[800];
//     bottomNavBarIconColor = Colors.white;
//   }

//   _setClassicTheme() {
//     redColor = Colors.red[900];
//     listTileColor = Colors.white;
//     textColor = Colors.black;
//     markBorderColor = null;
//     markPokemonColor = Colors.red;
//     subTextColor = Colors.grey[700];
//     captionTextColor = Colors.grey[600];
//     dividerColor = Colors.grey[500];
//     buttonColor = Colors.red[200];
//     iconColor = Colors.grey[600];
//     drawerColor = Colors.grey[100];
//     backgroundColor = Colors.white;
//     bottomNavBarColor = Colors.grey[100];
//     bottomNavBarIconColor = Colors.red[900];
//   }
