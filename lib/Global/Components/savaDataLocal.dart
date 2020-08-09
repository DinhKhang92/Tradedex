import 'package:shared_preferences/shared_preferences.dart';

void saveLanguageLocal(language) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('language', language);
}

void saveInitLocal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('initNew', false);
}

void saveColorThemeLocal(bool darkTheme) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setBool('darkTheme', darkTheme);
}

void saveIdLocal(id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString('myID', id);
}
