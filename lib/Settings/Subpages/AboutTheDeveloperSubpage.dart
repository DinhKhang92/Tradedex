import 'package:flutter/material.dart';
import 'package:tradedex/Global/GlobalConstants.dart';

class AboutTheDeveloperSubpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(languageFile['PAGE_SETTINGS']['ABOUT_THE_DEVEOPER_SUBPAGE']['TITLE']),
        backgroundColor: appBarColor,
      ),
      body: aboutTheDeveloperSubpageBody(),
    );
  }
}

Widget aboutTheDeveloperSubpageBody() {
  return Container(
    color: backgroundColor,
    child: ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            border: Border.all(
              color: dividerColor,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(1.0),
            child: Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(text: languageFile['PAGE_SETTINGS']['ABOUT_THE_DEVEOPER_SUBPAGE']['NOTE'] + '\n\n', style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                  TextSpan(
                    text: languageFile['PAGE_SETTINGS']['ABOUT_THE_DEVEOPER_SUBPAGE']['DESCRIPTION_01'] +
                        '\n\n' +
                        languageFile['PAGE_SETTINGS']['ABOUT_THE_DEVEOPER_SUBPAGE']['DESCRIPTION_02'] +
                        "\n\n" +
                        languageFile['PAGE_SETTINGS']['ABOUT_THE_DEVEOPER_SUBPAGE']['DESCRIPTION_03'] +
                        "\n\n" +
                        languageFile['PAGE_SETTINGS']['ABOUT_THE_DEVEOPER_SUBPAGE']['DESCRIPTION_04'],
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    ),
  );
}
