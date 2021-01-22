import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/pages/settings/components/subtitle.dart';
import 'package:tradedex/pages/settings/cubit/settings_cubit.dart';
import 'package:tradedex/localization/app_localization.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        key: this._scaffoldKey,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).translate('PAGE_SETTINGS.TITLE'),
            style: TextStyle(color: titleColor),
          ),
          backgroundColor: appBarColor,
        ),
        body: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return ListView(
      children: [
        buildSubtitle(AppLocalizations.of(context)
            .translate('PAGE_SETTINGS.PROFILE_SUBTITLE')),
        _buildProfileDetails(),
        Divider(color: dividerColor),
        buildSubtitle(AppLocalizations.of(context)
            .translate('PAGE_SETTINGS.TRADEDEX_SUBTITLE')),
        _buildLanguageElement(),
        _buildThemeColorElement(),
        Divider(color: dividerColor),
        buildSubtitle(
            AppLocalizations.of(context).translate('PAGE_SETTINGS.SUPPORT')),
        _buildHelpCenter(),
        _buildReport(),
        Divider(color: dividerColor),
        buildSubtitle(
            AppLocalizations.of(context).translate('PAGE_SETTINGS.ABOUT')),
        _buildAbout(),
        _buildPolicy(),
        _buildToS()
      ],
    );
  }

  Widget _buildProfileDetails() {
    return Container(
      color: backgroundColor,
      child: ListTile(
        // onTap: () => changeAccountName(context),
        dense: true,
        leading: ButtonTheme(
          height: 40,
          minWidth: 40,
          padding: EdgeInsets.all(1.0),
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: () {
              // changeIcon();
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: new BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
                image: new DecorationImage(
                    alignment: Alignment.topRight,
                    fit: BoxFit.scaleDown,
                    image: AssetImage(
                        "assets_bundle/pokemon_icons_blank/001.png")),
              ),
            ),
          ),
        ),
        title: Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: "T0nb3rry",
                style: TextStyle(
                  fontSize: 16.0,
                  color: textColor,
                ),
              ),
              TextSpan(
                text: '\n' + "myProfile.id",
                style: TextStyle(
                  fontSize: 12.0,
                  height: 1.3,
                  color: subTextColor,
                ),
              ),
            ],
          ),
        ),
        subtitle: Text.rich(
          TextSpan(children: <TextSpan>[
            TextSpan(
              text: "\n" +
                  AppLocalizations.of(context)
                      .translate('PAGE_SETTINGS.CHANGE_PROFILE_NAME_AND_ICON'),
              style: TextStyle(
                fontSize: 12.0,
                color: subTextColor,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildLanguageElement() {
    return Container(
      color: backgroundColor,
      child: ListTile(
        onTap: () {
          // changeLanguage();
        },
        dense: true,
        title: Text.rich(
          TextSpan(children: <TextSpan>[
            TextSpan(
                text: AppLocalizations.of(context)
                    .translate('PAGE_SETTINGS.TRADEDEX_LANGUAGE'),
                style: TextStyle(
                  fontSize: 15.0,
                  color: textColor,
                )),
            TextSpan(
              text: '\n' + 'TODO',
              style: TextStyle(
                fontSize: 12.0,
                height: 1.3,
                color: subTextColor,
              ),
            ),
            TextSpan(
              text: '\n\n' +
                  AppLocalizations.of(context)
                      .translate('PAGE_SETTINGS.TRADEDEX_DESCRIPTION'),
              style: TextStyle(
                fontSize: 12.0,
                height: 1.0,
                color: subTextColor,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildThemeColorElement() {
    return Container(
      color: backgroundColor,
      child: ListTile(
        trailing: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Switch(
              activeColor: buttonColor,
              value: state.isDarkTheme,
              onChanged: (choice) =>
                  BlocProvider.of<SettingsCubit>(context).toggleTheme(),
              // onChanged: (bool choice) {
              //   setState(() {
              //     this.darkTheme = choice;
              //     setColorTheme(this.darkTheme);
              //   });
              //   saveColorThemeLocal(this.darkTheme);
              // },
            );
          },
        ),
        title: Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: AppLocalizations.of(context)
                    .translate('PAGE_SETTINGS.DARK_THEME_TITLE'),
                style: TextStyle(
                  fontSize: 15.0,
                  color: textColor,
                ),
              ),
              TextSpan(
                text: '\n' +
                    AppLocalizations.of(context)
                        .translate('PAGE_SETTINGS.DARK_THEME_DESCRIPTION'),
                style: TextStyle(
                  fontSize: 12.0,
                  height: 1.3,
                  color: subTextColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // void loadLanguage(String selected) async {
  //   selectedLanguage = selected;
  //   if (selected == 'en')
  //     rootBundle.loadString("json/languages/en.json").then((String file) {
  //       setState(() {
  //         languageFile = json.decode(file);
  //       });
  //     });
  //   else
  //     rootBundle.loadString("json/languages/de.json").then((String file) {
  //       setState(() {
  //         languageFile = json.decode(file);
  //       });
  //     });
  // }

  // void changeLanguage() async {
  //   int languageValue = 0;
  //   if (selectedLanguage == 'de') {
  //     languageValue = 1;
  //   }
  //   await showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: backgroundColor,
  //         title: Text(
  //           languageFile['PAGE_SETTINGS']['DIALOG_LANGUAGE']['SELECT_LANGUAGE_TITLE'],
  //           style: TextStyle(color: textColor),
  //         ),
  //         content: Column(
  //           children: <Widget>[
  //             Row(
  //               children: <Widget>[
  //                 Theme(
  //                   data: Theme.of(context).copyWith(unselectedWidgetColor: subTextColor),
  //                   child: Radio(
  //                     value: 0,
  //                     activeColor: buttonColor,
  //                     groupValue: languageValue,
  //                     onChanged: (int value) {
  //                       loadLanguage('en');
  //                       saveLanguageLocal('en');
  //                       Navigator.of(context).pop();
  //                     },
  //                   ),
  //                 ),
  //                 Text(
  //                   languageFile['LANGUAGES']['ENGLISH'],
  //                   style: TextStyle(color: textColor),
  //                 )
  //               ],
  //             ),
  //             Row(
  //               children: <Widget>[
  //                 Theme(
  //                   data: Theme.of(context).copyWith(unselectedWidgetColor: subTextColor),
  //                   child: Radio(
  //                     value: 1,
  //                     activeColor: buttonColor,
  //                     groupValue: languageValue,
  //                     onChanged: (int value) {
  //                       loadLanguage('de');
  //                       saveLanguageLocal('de');
  //                       Navigator.of(context).pop();
  //                     },
  //                   ),
  //                 ),
  //                 Text(
  //                   languageFile['LANGUAGES']['GERMAN'],
  //                   style: TextStyle(color: textColor),
  //                 )
  //               ],
  //             )
  //           ],
  //         ),
  //         actions: <Widget>[
  //           FlatButton(
  //             child: Text(
  //               languageFile['PAGE_SETTINGS']['DIALOG_LANGUAGE']['CLOSE'],
  //               style: TextStyle(color: buttonColor),
  //             ),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void changeAccountName(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       backgroundColor: backgroundColor,
  //       contentPadding: const EdgeInsets.all(18.0),
  //       content: Row(
  //         children: <Widget>[
  //           Form(
  //             child: Expanded(
  //               child: TextFormField(
  //                 style: TextStyle(color: textColor),
  //                 onFieldSubmitted: (String newAccountName) {
  //                   setState(() {
  //                     this.myProfile.accountName = newAccountName;
  //                   });
  //                   saveAccountNameFirebase(myProfile);
  //                   Navigator.pop(context);
  //                 },
  //                 controller: textController,
  //                 autofocus: true,
  //                 cursorColor: buttonColor,
  //                 decoration: InputDecoration(
  //                   focusedBorder: UnderlineInputBorder(
  //                     borderSide: BorderSide(color: textColor),
  //                   ),
  //                   labelText: languageFile['PAGE_SETTINGS']['YOUR_NEW_TRAINER_NAME'],
  //                   labelStyle: TextStyle(color: textColor),
  //                   hintText: languageFile['PAGE_SETTINGS']['TRAINER_XY'],
  //                   hintStyle: TextStyle(color: prefillTextColor),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           CircleAvatar(
  //             backgroundColor: buttonColor,
  //             child: IconButton(
  //               icon: Icon(
  //                 Icons.send,
  //                 color: buttonTextColor,
  //               ),
  //               color: iconColor,
  //               onPressed: () {
  //                 setState(() {
  //                   this.myProfile.accountName = this.textController.text;
  //                 });
  //                 // _saveMyAccountName();
  //                 saveAccountNameFirebase(myProfile);
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // void changeIcon() async {
  //   await showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: dialogBackgroundColor,
  //         title: Text(
  //           languageFile['PAGE_SETTINGS']['CHOOSE_ICON'],
  //           style: TextStyle(color: textColor),
  //         ),
  //         content: Container(
  //           width: 150,
  //           child: GridView.builder(
  //             itemCount: this.pokemonNamesDictKeys.length,
  //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
  //             itemBuilder: (context, i) {
  //               String idx = this.pokemonNamesDictKeys[i];
  //               return GridTile(
  //                 child: InkResponse(
  //                   child: Container(
  //                     height: 10,
  //                     width: 10,
  //                     decoration: new BoxDecoration(
  //                       color: Colors.grey[300],
  //                       shape: BoxShape.circle,
  //                       image: new DecorationImage(
  //                         fit: BoxFit.scaleDown,
  //                         image: getPokemonImage(idx),
  //                       ),
  //                     ),
  //                   ),
  //                   onTap: () {
  //                     setState(() {
  //                       this.myProfile.icon = idx;
  //                     });
  //                     // _saveMyIcon();
  //                     // _updateFireBase();
  //                     saveIconFirebase(myProfile);
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildHelpCenter() {
    return Container(
      color: backgroundColor,
      child: ListTile(
        onTap: () => Navigator.of(context).pushNamed('/faq'),
        title: Text.rich(
          TextSpan(children: <TextSpan>[
            TextSpan(
              text: AppLocalizations.of(context)
                  .translate('PAGE_SETTINGS.SUPPORT_TITLE'),
              style: TextStyle(
                fontSize: 15.0,
                height: 0.0,
                color: textColor,
              ),
            ),
            TextSpan(
              text: '\n' +
                  AppLocalizations.of(context)
                      .translate('PAGE_SETTINGS.SUPPORT_DESCRIPTION'),
              style: TextStyle(
                fontSize: 12.0,
                height: 1.4,
                color: subTextColor,
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget _buildReport() {
    return Container(
      color: backgroundColor,
      child: ListTile(
        // onTap: () => goToUrl(
        //     'mailto:Dinh.Khang.Tradedex@gmail.com?subject=Bug Report&body=Enter your text ...'),
        title: Text.rich(
          TextSpan(children: <TextSpan>[
            TextSpan(
              text: AppLocalizations.of(context)
                  .translate('PAGE_SETTINGS.REPORT_TITLE'),
              style: TextStyle(
                fontSize: 15.0,
                height: 0.0,
                color: textColor,
              ),
            ),
            TextSpan(
              text: '\n' +
                  AppLocalizations.of(context)
                      .translate('PAGE_SETTINGS.REPORT_DESCRIPTION'),
              style: TextStyle(
                fontSize: 12.0,
                height: 1.4,
                color: subTextColor,
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget _buildPolicy() {
    return Container(
      color: backgroundColor,
      child: ListTile(
        // onTap: () => goToUrl('https://github.com/DinhKhang92/Tradedex/blob/master/Privacy_Policy.md'),
        title: Text.rich(
          TextSpan(children: <TextSpan>[
            TextSpan(
              text: AppLocalizations.of(context)
                  .translate('PAGE_SETTINGS.DATA_POLICY'),
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

  Widget _buildAbout() {
    return Container(
      color: backgroundColor,
      child: ListTile(
        onTap: () {},
        title: Text.rich(
          TextSpan(children: <TextSpan>[
            TextSpan(
              text: AppLocalizations.of(context)
                  .translate('PAGE_SETTINGS.ABOUT_TITLE'),
              style: TextStyle(
                fontSize: 15.0,
                height: 0.0,
                color: textColor,
              ),
            ),
            TextSpan(
              text: '\n' +
                  AppLocalizations.of(context)
                      .translate('PAGE_SETTINGS.ABOUT_DESCRIPTION'),
              style: TextStyle(
                fontSize: 12.0,
                height: 1.4,
                color: subTextColor,
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget _buildToS() {
    return Container(
      color: backgroundColor,
      child: ListTile(
        // onTap: () => goToUrl('https://github.com/DinhKhang92/Tradedex/blob/master/Terms_of_Service.md'),
        title: Text.rich(
          TextSpan(children: <TextSpan>[
            TextSpan(
              text: AppLocalizations.of(context)
                  .translate('PAGE_SETTINGS.TERMS_OF_USE'),
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
}

//   void _saveMyAccountName() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('myAccountName', myAccountName);
//   }

//   void _updateFireBase() {
//     database.reference().child(myID).update({
//       'icon': prefix0.myIcon,
//       'account_name': myAccountName,
//     });
//   }

//   void _saveMyIcon() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('icon', prefix0.myIcon);
//   }

//   void _saveMyTheme() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('theme', prefix0.myClassicTheme);
//   }

//   void _changeTheme(bool choice) {
//     myClassicTheme = !myClassicTheme;
//     if (myClassicTheme == false)
//       _setClassicTheme();
//     else
//       _setDarkTheme();
//   }

//   _setDarkTheme() {
//     redColor = Colors.grey[800];
//     listTileColor = Colors.black87;
//     textColor = Colors.white;
//     markBorderColor = Colors.white70;
//     markPokemonColor = Colors.red[900];
//     subTextColor = Colors.white54;
//     captionTextColor = Colors.white54;
//     dividerColor = Colors.grey[600];
//     buttonColor = Colors.grey[600];
//     iconColor = Colors.white;
//     drawerColor = Colors.black87;
//     backgroundColor = Colors.black87;
//     bottomNavBarColor = Colors.grey[800];
//     bottomNavBarIconColor = Colors.white;
//   }

//   _setClassicTheme() {
//     redColor = Colors.red[900];
//     listTileColor = Colors.white;
//     textColor = Colors.black;
//     markBorderColor = null;
//     markPokemonColor = Colors.red;
//     subTextColor = Colors.grey[700];
//     captionTextColor = Colors.grey[600];
//     dividerColor = Colors.grey[500];
//     buttonColor = Colors.red[200];
//     iconColor = Colors.grey[600];
//     drawerColor = Colors.grey[100];
//     backgroundColor = Colors.white;
//     bottomNavBarColor = Colors.grey[100];
//     bottomNavBarIconColor = Colors.red[900];
//   }
