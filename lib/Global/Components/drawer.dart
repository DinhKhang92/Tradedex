import 'package:flutter/material.dart';
import 'package:tradedex/Global/GlobalConstants.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Widget getUserVerification(isSignedIn, myID) {
  return Row(
    children: <Widget>[
      isSignedIn == false
          ? Icon(
              MdiIcons.shieldOutline,
              size: 15,
              color: Colors.red[900],
            )
          : Icon(
              Icons.verified_user,
              size: 15,
              color: Colors.green[800],
            ),
      SizedBox(
        width: 5,
      ),
      Text(
        myID,
        style: TextStyle(color: subTextColor, fontSize: 13),
      )
    ],
  );
}
