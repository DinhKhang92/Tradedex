import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:flutter/gestures.dart';

getUrlPp() async {
  const url = 'https://github.com/DinhKhang92/Tradedex/blob/master/Privacy_Policy.md';
  if (await canLaunch(url))
    await launch(url);
  else
    throw 'Could not launch $url.';
}

getUrlTos() async {
  const url = 'https://github.com/DinhKhang92/Tradedex/blob/master/Terms_of_Service.md';
  if (await canLaunch(url))
    await launch(url);
  else
    throw 'Could not launch $url.';
}

Widget getTermsOfService() {
  return Center(
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: languageFile['PAGE_START']['TOS_AND_PRIVACY_TEXT_1'],
        style: TextStyle(color: textColor),
        children: <TextSpan>[
          TextSpan(
              style: TextStyle(
                color: urlColor,
              ),
              text: languageFile['PAGE_START']['TOS'],
              recognizer: TapGestureRecognizer()..onTap = () => getUrlTos()),
          TextSpan(text: languageFile['PAGE_START']['TOS_AND_PRIVACY_TEXT_2']),
          TextSpan(
              style: TextStyle(
                color: urlColor,
              ),
              text: languageFile['PAGE_START']['PRIVACY'],
              recognizer: TapGestureRecognizer()..onTap = () => getUrlPp()),
          TextSpan(text: languageFile['PAGE_START']['TOS_AND_PRIVACY_TEXT_3']),
        ],
      ),
    ),
  );
}
