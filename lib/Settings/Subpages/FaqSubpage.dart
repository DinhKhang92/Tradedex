import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:tradedex/Settings/Components/goToUrl.dart';
import '../../Global/GlobalConstants.dart';
import 'package:tradedex/Global/Components/customExpansionTile.dart' as custom;

class FaqSubpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['TITLE'],
          style: TextStyle(color: titleColor),
        ),
        backgroundColor: appBarColor,
      ),
      body: faqSubpageBody(),
    );
  }
}

Widget faqSubpageBody() {
  return Container(
    color: backgroundColor,
    child: ListView(
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        Wrap(
          children: <Widget>[
            Card(
              color: dialogBackgroundColor,
              child: custom.ExpansionTile(
                headerBackgroundColor: dialogBackgroundColor,
                iconColor: buttonColor,
                title: Text(
                  languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_01_TITLE'],
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 45.0, 10.0),
                    child: Text(
                      languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_01_DESCRIPTION'],
                      style: TextStyle(color: textColor),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Wrap(
          children: <Widget>[
            Card(
              color: dialogBackgroundColor,
              child: custom.ExpansionTile(
                headerBackgroundColor: dialogBackgroundColor,
                iconColor: buttonColor,
                title: Text(
                  languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_02_TITLE'],
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 45.0, 10.0),
                    child: Text(
                      languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_02_DESCRIPTION'],
                      style: TextStyle(color: textColor),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Wrap(
          children: <Widget>[
            Card(
              color: dialogBackgroundColor,
              child: custom.ExpansionTile(
                headerBackgroundColor: dialogBackgroundColor,
                iconColor: buttonColor,
                title: Text(
                  languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_03_TITLE'],
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 10.0, 45.0, 10.0),
                    child: Text(
                      languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_03_DESCRIPTION'],
                      style: TextStyle(color: textColor),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Wrap(
          children: <Widget>[
            Card(
              color: dialogBackgroundColor,
              child: custom.ExpansionTile(
                headerBackgroundColor: dialogBackgroundColor,
                iconColor: buttonColor,
                title: Text(
                  languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_04_TITLE'],
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 45.0, 10.0),
                    child: Text(
                      languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_04_DESCRIPTION'],
                      style: TextStyle(color: textColor),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Wrap(
          children: <Widget>[
            Card(
              color: dialogBackgroundColor,
              child: custom.ExpansionTile(
                headerBackgroundColor: dialogBackgroundColor,
                iconColor: buttonColor,
                title: Text(
                  languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_05_TITLE'],
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 10.0, 45.0, 10.0),
                    child: Text(
                      languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_05_DESCRIPTION'],
                      style: TextStyle(color: textColor),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Wrap(
          children: <Widget>[
            Card(
              color: dialogBackgroundColor,
              child: custom.ExpansionTile(
                headerBackgroundColor: dialogBackgroundColor,
                iconColor: buttonColor,
                title: Text(
                  languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_06_TITLE'],
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 45.0, 10.0),
                    child: Text(
                      languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_06_DESCRIPTION'],
                      style: TextStyle(color: textColor),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Wrap(
          children: <Widget>[
            Card(
              color: dialogBackgroundColor,
              child: custom.ExpansionTile(
                headerBackgroundColor: dialogBackgroundColor,
                iconColor: buttonColor,
                title: Text(
                  languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_07_TITLE'],
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 45.0, 10.0),
                    child: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_07_DESCRIPTION'],
                          ),
                          TextSpan(
                            style: TextStyle(color: urlColor),
                            text: languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_07_01_DESCRIPTION'],
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                goToUrl('https://www.imore.com/how-use-text-shortcuts-iphone-and-ipad');
                              },
                          ),
                          TextSpan(text: languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_07_02_DESCRIPTION'])
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Wrap(
          children: <Widget>[
            Card(
              color: dialogBackgroundColor,
              child: custom.ExpansionTile(
                headerBackgroundColor: dialogBackgroundColor,
                iconColor: buttonColor,
                title: Text(
                  languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_08_TITLE'],
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 45.0, 10.0),
                    child: Text(
                      languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_08_DESCRIPTION'],
                      style: TextStyle(color: textColor),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Center(
          child: FlatButton(
            child: Chip(
              labelPadding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
              backgroundColor: buttonColor,
              label: Text(
                languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['BUTTON_FEEDBACK'],
                style: TextStyle(color: buttonTextColor),
              ),
            ),
            onPressed: () => goToUrl('mailto:Dinh.Khang.Tradedex@gmail.com?subject=Bug Report&body=Enter your text ...'),
          ),
        ),
      ],
    ),
  );
}
