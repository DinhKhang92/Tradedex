import 'package:flutter/material.dart';

// General
List<String> myNeedList = List<String>();
List<String> myMostWantedList = List<String>();
String myID;
// String myAccountName = 'Trainer xy';
String myIcon = '001';
String myLanguage = 'en';
List<String> myFriends = List<String>();
// bool myClassicTheme = false;
String myVersion = '1.0.0';
bool isSignedIn = false;
bool initNew = true;

// color theme
Color titleColor;
Color backgroundColor;
Color buttonTextColor;
Color buttonColor;
Color urlColor;
Color appBarColor;
Color primaryListColor;
Color primaryListColorOff;
Color secondaryListColor;
Color secondaryListColorOff;
Color iconColor;
Color searchCursorColor;
Color textColor;
Color drawerIconColor;
Color silhouetteColor;
Color genderMaleColor;
Color genderFemaleColor;
Color genderNeutralColor;
Color genderMaleColorOff;
Color genderFemaleColorOff;
Color genderNeutralColorOff;
Color dividerColor;
Color dismissibleColor;
Color signInButtonColor;
Color prefillTextColor;
Color subTextColor;
Color captionTextColor;
Color dialogBackgroundColor;
Color inputBorderColor;
Color inputColor;

// languages
String selectedLanguage;
Map languageFile;
Map rootLanguageFile;

// profile
class Profile {
  String accountName;
  String id;
  String icon;
  List<String> primaryList;
  List<String> secondaryList;
}

// official collection
class OfficialCollection {
  List<String> luckyList;
  List<String> shinyList;
  List<String> maleList;
  List<String> femaleList;
  List<String> neutralList;

  OfficialCollection() {
    this.luckyList = new List<String>();
    this.shinyList = new List<String>();
    this.maleList = new List<String>();
    this.femaleList = new List<String>();
    this.neutralList = new List<String>();
  }
}

class Contact {
  String accountName;
  String id;
  String icon;
  List<String> primaryList;
  List<String> secondaryList;

  OfficialCollection officialCollection;
}

enum ListTypes {
  alolan,
  event,
  galarian,
  pokedex,
  purified,
  regional,
  shadow,
  spinda,
  unown,
}
