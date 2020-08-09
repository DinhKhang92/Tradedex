import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:tradedex/Global/Components/setColorTheme.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'dart:async';

import 'dart:convert';

// load if new installation
Future<bool> loadInitNew(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initNew = prefs.getBool('initNew') ?? true;

  return initNew;
}

// load language
Future<Map> loadLanguage(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  selectedLanguage = prefs.getString('language') ?? 'en';

  if (selectedLanguage == 'en')
    await rootBundle.loadString("json/languages/en.json").then((String file) => languageFile = json.decode(file));
  else
    await rootBundle.loadString("json/languages/de.json").then((String file) => languageFile = json.decode(file));

  // get root language file
  await rootBundle.loadString("json/languages/en.json").then((String file) => rootLanguageFile = json.decode(file));
  return languageFile;
}

Future<bool> loadColorTheme() async {
  bool darkTheme;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  darkTheme = prefs.getBool('darkTheme') ?? false;

  setColorTheme(darkTheme);
  return darkTheme;
}
