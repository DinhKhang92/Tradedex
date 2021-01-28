import 'package:flutter/material.dart';

import 'package:tradedex/Global/GlobalConstants.dart';

Widget buildSubtitle(String subtitle) {
  return Container(
    child: ListTile(
      dense: true,
      title: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: subtitle,
              style: TextStyle(color: Color(0xffee6c4d), fontSize: 14.0),
            ),
          ],
        ),
      ),
    ),
  );
}
