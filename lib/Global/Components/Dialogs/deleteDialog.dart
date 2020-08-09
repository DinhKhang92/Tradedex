import 'package:flutter/material.dart';
import 'package:tradedex/Global/GlobalConstants.dart';

Widget deleteDialog(BuildContext context, List<String> pokemonList) {
  return AlertDialog(
    backgroundColor: dialogBackgroundColor,
    title: Text(
      languageFile['DIALOG_DELETE']['TITLE'],
      style: TextStyle(color: textColor),
    ),
    content: Text(
      languageFile['DIALOG_DELETE']['DESCRIPTION'],
      style: TextStyle(color: textColor),
    ),
    actions: <Widget>[
      FlatButton(
        child: Text(
          languageFile['DIALOG_DELETE']['CANCEL'],
          style: TextStyle(color: buttonColor),
        ),
        onPressed: () {
          Navigator.of(context).pop(pokemonList);
        },
      ),
      FlatButton(
        child: Text(
          languageFile['DIALOG_DELETE']['ACCEPT'],
          style: TextStyle(color: buttonColor),
        ),
        onPressed: () {
          pokemonList.clear();
          Navigator.of(context).pop(pokemonList);
          // _updateFireBase();
          // _saveMyMostWantedList();
        },
      )
    ],
  );
}
