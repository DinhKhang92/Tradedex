import 'package:flutter/material.dart';

import 'package:tradedex/Global/GlobalConstants.dart';

Widget buildSubtitle(String subtitle) {
  return Container(
    color: backgroundColor,
    child: ListTile(
      dense: true,
      title: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: subtitle,
              style: TextStyle(color: captionTextColor, fontSize: 14.0),
            ),
          ],
        ),
      ),
    ),
  );
}
