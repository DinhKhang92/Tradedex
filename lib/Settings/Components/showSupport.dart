import 'package:flutter/material.dart';
import '../Subpages/FaqSubpage.dart';

import 'package:tradedex/Global/GlobalConstants.dart';

Widget showSupport() {
  return Container(
    color: backgroundColor,
    child: ListTile(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => FaqSubpage()),
        // );
      },
      title: Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(
            text: languageFile['PAGE_SETTINGS']['SUPPORT_TITLE'],
            style: TextStyle(
              fontSize: 15.0,
              height: 0.0,
              color: textColor,
            ),
          ),
          TextSpan(
            text: '\n' + languageFile['PAGE_SETTINGS']['SUPPORT_DESCRIPTION'],
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
