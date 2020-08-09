import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:flutter/material.dart';

void setColorTheme(darkTheme) {
  if (darkTheme == false) {
    titleColor = Color(0xfffcfcfc);
    backgroundColor = Color(0xfffcfcfc);
    buttonTextColor = Color(0xfffcfcfc);
    searchCursorColor = Color(0xfffcfcfc);
    iconColor = Color(0xfffcfcfc);
    dialogBackgroundColor = Color(0xfffcfcfc);

    buttonColor = Color(0xff3860aa);
    urlColor = Color(0xff3860aa);
    appBarColor = Color(0xff3860aa);
    drawerIconColor = Color(0xff3860aa);
    genderMaleColor = Color(0xff3860aa);
    dividerColor = Color(0xff3860aa);
    dismissibleColor = Color(0xff3860aa);
    captionTextColor = Color(0xff3860aa);

    primaryListColor = Color(0xffe63946);
    genderFemaleColor = Color(0xffe63946);

    secondaryListColor = Color(0xffffcd05);
    genderNeutralColor = Color(0xffffcd05);

    textColor = Color(0xff111111);
    inputBorderColor = Colors.black54;
    inputColor = Colors.black54;

    silhouetteColor = Color(0xff212529);

    signInButtonColor = Color(0xffa8dadc);

    prefillTextColor = Color(0xffcfd2cd);
    subTextColor = Colors.grey[700];

    primaryListColorOff = null;
    secondaryListColorOff = null;
    genderMaleColorOff = null;
    genderFemaleColorOff = null;
    genderNeutralColorOff = null;
  } else {
    titleColor = Color(0xfffcfcfc);
    backgroundColor = Color(0xff121212);
    buttonTextColor = Color(0xff121212);
    searchCursorColor = Color(0xfffcfcfc);
    iconColor = Color(0xfffcfcfc);
    dialogBackgroundColor = Color(0xff272727);

    buttonColor = Color(0xff84c9fb);
    urlColor = Color(0xff84c9fb);
    appBarColor = Color(0xff272727);
    drawerIconColor = Color(0xff84c9fb);
    genderMaleColor = Color(0xff84c9fb);
    dividerColor = Color(0xff84c9fb);
    dismissibleColor = Color(0xff84c9fb);
    captionTextColor = Color(0xff84c9fb);

    primaryListColor = Color(0xffe63946);
    genderFemaleColor = Color(0xffe63946);

    secondaryListColor = Color(0xffffcd05);
    genderNeutralColor = Color(0xffffcd05);

    textColor = Color(0xfffcfcfc);
    inputBorderColor = Color(0xfffcfcfc);
    inputColor = Color(0xfffcfcfc);

    silhouetteColor = Color(0xfffcfcfc);

    signInButtonColor = Color(0xff272727);

    prefillTextColor = Color(0xffbababa);
    subTextColor = Color(0xffbababa);

    primaryListColorOff = Color(0xffbababa);
    secondaryListColorOff = Color(0xffbababa);
    genderMaleColorOff = Color(0xfffcfcfc);
    genderFemaleColorOff = Color(0xfffcfcfc);
    genderNeutralColorOff = Color(0xfffcfcfc);
  }
}
