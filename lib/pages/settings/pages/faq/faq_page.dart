import 'package:flutter/material.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:tradedex/model/device.dart';
import 'package:tradedex/pages/settings/pages/faq/components/faq_item.dart';
import 'package:url_launcher/url_launcher.dart';

class FaqPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FaqPageState();
}

class FaqPageState extends State<FaqPage> with Device {
  final String _url = "mailto:Dinh.Khang.Tradedex@gmail.com?subject=Bug Report";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff242423),
      body: faqSubpageBody(),
    );
  }

  Widget faqSubpageBody() {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            height: Device.height - Device.safeAreaTop - 73 - Device.safeAreaBottom,
            child: ListView(
              children: [
                SizedBox(height: 10),
                FaqItem(
                  title: AppLocalizations.of(context).translate('PAGE_FAQ.CARD_01_TITLE'),
                  text: AppLocalizations.of(context).translate('PAGE_FAQ.CARD_01_DESCRIPTION'),
                ),
                SizedBox(height: 10),
                FaqItem(
                  title: AppLocalizations.of(context).translate('PAGE_FAQ.CARD_02_TITLE'),
                  text: AppLocalizations.of(context).translate('PAGE_FAQ.CARD_02_DESCRIPTION'),
                ),
                SizedBox(height: 10),
                FaqItem(
                  title: AppLocalizations.of(context).translate('PAGE_FAQ.CARD_03_TITLE'),
                  text: AppLocalizations.of(context).translate('PAGE_FAQ.CARD_03_DESCRIPTION'),
                ),
                SizedBox(height: 10),
                FaqItem(
                  title: AppLocalizations.of(context).translate('PAGE_FAQ.CARD_04_TITLE'),
                  text: AppLocalizations.of(context).translate('PAGE_FAQ.CARD_04_DESCRIPTION'),
                ),
                SizedBox(height: 10),
                FaqItem(
                  title: AppLocalizations.of(context).translate('PAGE_FAQ.CARD_05_TITLE'),
                  text: AppLocalizations.of(context).translate('PAGE_FAQ.CARD_05_DESCRIPTION'),
                ),
                SizedBox(height: 10),
                FaqItem(
                  title: AppLocalizations.of(context).translate('PAGE_FAQ.CARD_06_TITLE'),
                  text: AppLocalizations.of(context).translate('PAGE_FAQ.CARD_06_DESCRIPTION'),
                ),
                SizedBox(height: 10),
                FaqItem(
                  title: AppLocalizations.of(context).translate('PAGE_FAQ.CARD_07_TITLE'),
                  text: AppLocalizations.of(context).translate('PAGE_FAQ.CARD_07_DESCRIPTION'),
                ),
                SizedBox(height: 10),
                FaqItem(
                  title: AppLocalizations.of(context).translate('PAGE_FAQ.CARD_08_TITLE'),
                  text: AppLocalizations.of(context).translate('PAGE_FAQ.CARD_08_DESCRIPTION'),
                ),
                SizedBox(height: 10),
                _buildHelpButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 0),
      child: _buildNavbar(),
    );
  }

  Widget _buildNavbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        Text(
          AppLocalizations.of(context).translate('PAGE_FAQ.TITLE'),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Container(
          width: 48,
          height: 48,
          padding: EdgeInsets.all(8),
        ),
      ],
    );
  }

  Widget _buildHelpButton() {
    return Center(
      child: GestureDetector(
        child: Chip(
          padding: EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: Color(0xffee6c4d),
          label: Text(AppLocalizations.of(context).translate('PAGE_FAQ.BUTTON_FEEDBACK')),
        ),
        onTap: () => _sendMail(),
      ),
    );
  }

  void _sendMail() async {
    if (await canLaunch(this._url)) await launch(this._url);
  }
}

// Container(
//       color: backgroundColor,
//       child: ListView(
//         padding: EdgeInsets.all(10.0),
//         children: <Widget>[
//           Wrap(
//             children: <Widget>[
//               Card(
//                 color: dialogBackgroundColor,
//                 child: custom.ExpansionTile(
//                   headerBackgroundColor: dialogBackgroundColor,
//                   iconColor: buttonColor,
//                   title: Text(
//                     languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_01_TITLE'],
//                     style: TextStyle(
//                       color: buttonColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.fromLTRB(15.0, 0.0, 45.0, 10.0),
//                       child: Text(
//                         languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_01_DESCRIPTION'],
//                         style: TextStyle(color: textColor),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Wrap(
//             children: <Widget>[
//               Card(
//                 color: dialogBackgroundColor,
//                 child: custom.ExpansionTile(
//                   headerBackgroundColor: dialogBackgroundColor,
//                   iconColor: buttonColor,
//                   title: Text(
//                     languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_02_TITLE'],
//                     style: TextStyle(
//                       color: buttonColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.fromLTRB(15.0, 0.0, 45.0, 10.0),
//                       child: Text(
//                         languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_02_DESCRIPTION'],
//                         style: TextStyle(color: textColor),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Wrap(
//             children: <Widget>[
//               Card(
//                 color: dialogBackgroundColor,
//                 child: custom.ExpansionTile(
//                   headerBackgroundColor: dialogBackgroundColor,
//                   iconColor: buttonColor,
//                   title: Text(
//                     languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_03_TITLE'],
//                     style: TextStyle(
//                       color: buttonColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.fromLTRB(15.0, 10.0, 45.0, 10.0),
//                       child: Text(
//                         languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_03_DESCRIPTION'],
//                         style: TextStyle(color: textColor),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Wrap(
//             children: <Widget>[
//               Card(
//                 color: dialogBackgroundColor,
//                 child: custom.ExpansionTile(
//                   headerBackgroundColor: dialogBackgroundColor,
//                   iconColor: buttonColor,
//                   title: Text(
//                     languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_04_TITLE'],
//                     style: TextStyle(
//                       color: buttonColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.fromLTRB(15.0, 0.0, 45.0, 10.0),
//                       child: Text(
//                         languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_04_DESCRIPTION'],
//                         style: TextStyle(color: textColor),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Wrap(
//             children: <Widget>[
//               Card(
//                 color: dialogBackgroundColor,
//                 child: custom.ExpansionTile(
//                   headerBackgroundColor: dialogBackgroundColor,
//                   iconColor: buttonColor,
//                   title: Text(
//                     languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_05_TITLE'],
//                     style: TextStyle(
//                       color: buttonColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.fromLTRB(15.0, 10.0, 45.0, 10.0),
//                       child: Text(
//                         languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_05_DESCRIPTION'],
//                         style: TextStyle(color: textColor),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Wrap(
//             children: <Widget>[
//               Card(
//                 color: dialogBackgroundColor,
//                 child: custom.ExpansionTile(
//                   headerBackgroundColor: dialogBackgroundColor,
//                   iconColor: buttonColor,
//                   title: Text(
//                     languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_06_TITLE'],
//                     style: TextStyle(
//                       color: buttonColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.fromLTRB(15.0, 0.0, 45.0, 10.0),
//                       child: Text(
//                         languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_06_DESCRIPTION'],
//                         style: TextStyle(color: textColor),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Wrap(
//             children: <Widget>[
//               Card(
//                 color: dialogBackgroundColor,
//                 child: custom.ExpansionTile(
//                   headerBackgroundColor: dialogBackgroundColor,
//                   iconColor: buttonColor,
//                   title: Text(
//                     languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_07_TITLE'],
//                     style: TextStyle(
//                       color: buttonColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.fromLTRB(15.0, 0.0, 45.0, 10.0),
//                       child: Text.rich(
//                         TextSpan(
//                           children: <TextSpan>[
//                             TextSpan(
//                               text: languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_07_DESCRIPTION'],
//                               style: TextStyle(color: textColor),
//                             ),
//                             TextSpan(
//                               style: TextStyle(color: urlColor),
//                               text: languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_07_01_DESCRIPTION'],
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () {
//                                   // goToUrl('https://www.imore.com/how-use-text-shortcuts-iphone-and-ipad');
//                                 },
//                             ),
//                             TextSpan(
//                               text: languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_07_02_DESCRIPTION'],
//                               style: TextStyle(color: textColor),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Wrap(
//             children: <Widget>[
//               Card(
//                 color: dialogBackgroundColor,
//                 child: custom.ExpansionTile(
//                   headerBackgroundColor: dialogBackgroundColor,
//                   iconColor: buttonColor,
//                   title: Text(
//                     languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_08_TITLE'],
//                     style: TextStyle(
//                       color: buttonColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.fromLTRB(15.0, 0.0, 45.0, 10.0),
//                       child: Text(
//                         languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['CARD_08_DESCRIPTION'],
//                         style: TextStyle(color: textColor),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Center(
//             child: FlatButton(
//               child: Chip(
//                 labelPadding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
//                 backgroundColor: buttonColor,
//                 label: Text(
//                   languageFile['PAGE_SETTINGS']['FAQ_SUBPAGE']['BUTTON_FEEDBACK'],
//                   style: TextStyle(color: buttonTextColor),
//                 ),
//               ),
//               // onPressed: () => goToUrl('mailto:Dinh.Khang.Tradedex@gmail.com?subject=Bug Report&body=Enter your text ...'),
//             ),
//           ),
//         ],
//       ),
//     );
