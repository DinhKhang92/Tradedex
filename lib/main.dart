import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/Global/Components/loadDataLocal.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'dart:async';
import 'package:tradedex/SignIn/SignInPage.dart';
import 'package:tradedex/pages/home/cubit/pokemon_cubit.dart';
import 'package:tradedex/pages/official_collection/cubit/official_cubit.dart';
import 'package:tradedex/pages/settings/cubit/settings_cubit.dart';

import 'Global/GlobalConstants.dart';
import 'Global/Components/tos.dart';
import 'Global/Components/tradedexLogo.dart';

// import 'Home/HomePage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tradedex/Global/Components/loadDataFirebase.dart';
import 'package:tradedex/route/route_generator.dart';
import 'package:tradedex/localization/app_localization.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  final PokemonCubit _pokemonCubit = new PokemonCubit();
  final SettingsCubit _settingsCubit = new SettingsCubit();
  final OfficialCubit _officialCubit = new OfficialCubit();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PokemonCubit>(
          create: (context) => this._pokemonCubit,
        ),
        BlocProvider<SettingsCubit>(
          create: (context) => this._settingsCubit,
        ),
        BlocProvider<OfficialCubit>(
          create: (context) => this._officialCubit,
        ),
      ],
      child: FutureBuilder(
        future: Future.wait([
          loadInitNew(context),
          loadLanguage(context),
          loadProfile(),
          loadColorTheme(),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.data == null) {
            return Container(
              color: backgroundColor,
            );
          } else {
            return MaterialApp(
              theme: ThemeData(scaffoldBackgroundColor: backgroundColor),
              color: buttonColor,
              debugShowCheckedModeBanner: false,
              title: 'Tradedex',
              initialRoute: '/',
              onGenerateRoute: RouteGenerator.generateRoute,
              // home: (initNew || snapshot.data[2].id.length == '-1') ? LoginPage(snapshot.data[2]) : HomePage(snapshot.data[2]),
              // home: TestPage(),
              supportedLocales: [
                Locale('de', 'DE'),
                Locale('en', 'US'),
              ],
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                for (Locale supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale.languageCode &&
                      supportedLocale.countryCode == locale.countryCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
            );
          }
        },
      ),
    );
  }
}

// class LoginPage extends StatefulWidget {
//   final Profile myProfile;
//   LoginPage(this.myProfile);

//   @override
//   LoginPageState createState() => new LoginPageState(this.myProfile);
// }

// class LoginPageState extends State<LoginPage> {
//   static final formKey = GlobalKey<FormState>();
//   final databaseReference = FirebaseDatabase.instance.reference();
//   Profile myProfile;

//   LoginPageState(myProfile) {
//     this.myProfile = myProfile;

//     print(this.myProfile.accountName);
//     print(this.myProfile.id);
//     print(this.myProfile.primaryList);
//     print(this.myProfile.secondaryList);
//     print(this.myProfile.icon);
//   }

//   // void clearCache() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   prefs.clear();
//   //   print("cache cleared.");
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: Center(
//         child: ListView(
//           shrinkWrap: true,
//           padding: EdgeInsets.only(left: 24.0, right: 24.0),
//           children: <Widget>[
//             getHero(),
//             SizedBox(height: 48.0),
//             getNameField(),
//             getContinueButton(),
//             getTermsOfService(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget getContinueButton() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 16.0),
//       child: RaisedButton(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(24),
//         ),
//         onPressed: () {
//           if (formKey.currentState.validate()) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage(this.myProfile)));
//         },
//         padding: EdgeInsets.all(12),
//         color: buttonColor,
//         child: Text(languageFile['PAGE_START']['CONTINUE'], style: TextStyle(color: backgroundColor)),
//       ),
//     );
//   }

//   Widget getNameField() {
//     return Theme(
//       data: ThemeData(
//         hintColor: subTextColor,
//         cursorColor: buttonColor,
//       ),
//       child: Form(
//         key: formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             TextFormField(
//               style: TextStyle(color: textColor),
//               validator: (value) {
//                 if (value.isEmpty)
//                   return languageFile['PAGE_START']['ENTER_TRAINER_NAME_VALIDATION'];
//                 else {
//                   this.myProfile.accountName = value;
//                   return null;
//                 }
//               },
//               autofocus: false,
//               decoration: InputDecoration(
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: inputBorderColor),
//                   borderRadius: BorderRadius.circular(32.0),
//                 ),
//                 hintText: languageFile['PAGE_START']['ENTER_TRAINER_NAME'],
//                 contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: inputBorderColor),
//                   borderRadius: BorderRadius.circular(32.0),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
