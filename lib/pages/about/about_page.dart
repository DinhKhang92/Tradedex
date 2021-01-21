import 'package:flutter/material.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/localization/app_localization.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('PAGE_ABOUT.TITLE'),
          style: TextStyle(color: titleColor),
        ),
        backgroundColor: appBarColor,
      ),
      body: AboutPageBody(),
    );
  }
}

class AboutPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Align(
        alignment: Alignment(0.0, -0.6),
        child: Container(
          alignment: Alignment.topCenter,
          height: 350.0,
          width: 350.0,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            border: Border.all(color: dividerColor),
          ),
          child: Center(
            child: Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(text: AppLocalizations.of(context).translate('PAGE_ABOUT.SUBTITLE'), style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                  TextSpan(text: AppLocalizations.of(context).translate('PAGE_ABOUT.TEXT_1'), style: TextStyle(color: textColor)),
                  TextSpan(text: AppLocalizations.of(context).translate('PAGE_ABOUT.TEXT_2'), style: TextStyle(color: textColor)),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
