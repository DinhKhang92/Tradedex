import 'package:flutter/material.dart';

import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/Settings/Components/goToUrl.dart';

//     var url = 'mailto:$toMailId?subject=$subject&body=$body';
Widget showReport() {
  return Container(
    color: backgroundColor,
    child: ListTile(
      onTap: () => goToUrl('mailto:Dinh.Khang.Tradedex@gmail.com?subject=Bug Report&body=Enter your text ...'),
      title: Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(
            text: languageFile['PAGE_SETTINGS']['REPORT_TITLE'],
            style: TextStyle(
              fontSize: 15.0,
              height: 0.0,
              color: textColor,
            ),
          ),
          TextSpan(
            text: '\n' + languageFile['PAGE_SETTINGS']['REPORT_DESCRIPTION'],
            style: TextStyle(
              fontSize: 12.0,
              height: 1.4,
              color: subTextColor,
            ),
          )
        ]),
      ),
    ),
  );
}
