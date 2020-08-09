import 'package:flutter/material.dart';
import 'package:tradedex/Global/GlobalConstants.dart';

Widget showProfile(Profile myProfile, context, changeAccountName, changeIcon, getPokemonImage) {
  return Container(
    color: backgroundColor,
    child: ListTile(
      onTap: () => changeAccountName(context),
      dense: true,
      leading: ButtonTheme(
        height: 40,
        minWidth: 40,
        padding: EdgeInsets.all(1.0),
        child: FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: () {
            changeIcon();
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: new BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
              image: new DecorationImage(alignment: Alignment.topRight, fit: BoxFit.scaleDown, image: getPokemonImage(myProfile.icon)),
            ),
          ),
        ),
      ),
      title: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: myProfile.accountName,
              style: TextStyle(
                fontSize: 16.0,
                color: textColor,
              ),
            ),
            TextSpan(
              text: '\n' + myProfile.id,
              style: TextStyle(
                fontSize: 12.0,
                height: 1.3,
                color: subTextColor,
              ),
            ),
          ],
        ),
      ),
      subtitle: Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(
            text: "\n" + languageFile['PAGE_SETTINGS']['CHANGE_PROFILE_NAME_AND_ICON'],
            style: TextStyle(
              fontSize: 12.0,
              color: subTextColor,
            ),
          ),
        ]),
      ),
    ),
  );
}
