import 'package:flutter/material.dart';

import 'package:tradedex/Global/GlobalConstants.dart';

String mapLanguage() {
  if (selectedLanguage == 'en')
    return 'English';
  else
    return 'Deutsch';
}

Widget showTradedex(Function changeLanguage) {
  return Container(
    color: backgroundColor,
    child: ListTile(
      onTap: () {
        changeLanguage();
      },
      dense: true,
      title: Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(
              text: languageFile['PAGE_SETTINGS']['TRADEDEX_LANGUAGE'],
              style: TextStyle(
                fontSize: 15.0,
                color: textColor,
              )),
          TextSpan(
            text: '\n' + mapLanguage(),
            style: TextStyle(
              fontSize: 12.0,
              height: 1.3,
              color: subTextColor,
            ),
          ),
          TextSpan(
            text: '\n\n' + languageFile['PAGE_SETTINGS']['TRADEDEX_DESCRIPTION'],
            style: TextStyle(
              fontSize: 12.0,
              height: 1.0,
              color: subTextColor,
            ),
          ),
        ]),
      ),
    ),
  );
}
