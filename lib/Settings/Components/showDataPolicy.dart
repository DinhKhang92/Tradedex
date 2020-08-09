import 'package:flutter/material.dart';

import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/Settings/Components/goToUrl.dart';

Widget showDataPolicy() {
  return Container(
    color: backgroundColor,
    child: ListTile(
      onTap: () => goToUrl('https://github.com/DinhKhang92/Tradedex/blob/master/Privacy_Policy.md'),
      title: Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(
            text: languageFile['PAGE_SETTINGS']['DATA_POLICY'],
            style: TextStyle(
              fontSize: 15.0,
              height: 0.0,
              color: textColor,
            ),
          ),
        ]),
      ),
    ),
  );
}
