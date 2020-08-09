import 'package:flutter/material.dart';
import 'package:tradedex/Global/GlobalConstants.dart';

Widget showTradedexSubtitle() {
  return Container(
    color: backgroundColor,
    child: ListTile(
      dense: true,
      title: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: languageFile['PAGE_SETTINGS']['TRADEDEX_SUBTITLE'],
              style: TextStyle(color: captionTextColor, fontSize: 14.0),
            ),
          ],
        ),
      ),
    ),
  );
}
