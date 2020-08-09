import 'package:flutter/material.dart';

import 'package:tradedex/Global/GlobalConstants.dart';

Widget showSupportSubtitle() {
  return Container(
    color: backgroundColor,
    child: ListTile(
      dense: true,
      title: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: languageFile['PAGE_SETTINGS']['SUPPORT'],
              style: TextStyle(color: captionTextColor, fontSize: 14.0),
            ),
          ],
        ),
      ),
    ),
  );
}
