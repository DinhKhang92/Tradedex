import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/Global/Components/loadDataLocal.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'dart:async';
import 'package:tradedex/pages/signin/cubit/signin_cubit.dart';
import 'package:tradedex/cubit/localization_cubit.dart';
import 'package:tradedex/pages/contacts/cubit/contacts_cubit.dart';
import 'package:tradedex/pages/home/cubit/pokemon_cubit.dart';
import 'package:tradedex/pages/individual_collection/cubit/individual_cubit.dart';
import 'package:tradedex/pages/official_collection/cubit/official_cubit.dart';
import 'package:tradedex/pages/settings/cubit/settings_cubit.dart';

import 'Global/GlobalConstants.dart';

import 'package:tradedex/cubit/account_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tradedex/Global/Components/loadDataFirebase.dart';
import 'package:tradedex/route/route_generator.dart';
import 'package:tradedex/localization/app_localization.dart';

import 'package:tradedex/pages/contacts/pages/contact_overview/cubit/contact_overview_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tradedex/model/device.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget with Device {
  final LocalizationCubit _localizationCubit = new LocalizationCubit();
  final AccountCubit _accountCubit = new AccountCubit();
  final PokemonCubit _pokemonCubit = new PokemonCubit();
  final SettingsCubit _settingsCubit = new SettingsCubit();
  final OfficialCubit _officialCubit = new OfficialCubit();
  final IndividualCubit _individualCubit = new IndividualCubit();
  final ContactsCubit _contactsCubit = new ContactsCubit();
  final SigninCubit _signinCubit = new SigninCubit();
  final ContactOverviewCubit _contactOverviewCubit = new ContactOverviewCubit();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountCubit>(
          create: (_) => this._accountCubit,
        ),
        BlocProvider<LocalizationCubit>(
          create: (_) => this._localizationCubit,
        ),
        BlocProvider<PokemonCubit>(
          create: (_) => this._pokemonCubit,
        ),
        BlocProvider<SettingsCubit>(
          create: (_) => this._settingsCubit,
        ),
        BlocProvider<OfficialCubit>(
          create: (_) => this._officialCubit,
        ),
        BlocProvider<IndividualCubit>(
          create: (_) => this._individualCubit,
        ),
        BlocProvider<ContactsCubit>(
          create: (_) => this._contactsCubit,
        ),
        BlocProvider<SigninCubit>(
          create: (_) => this._signinCubit,
        ),
        BlocProvider<ContactOverviewCubit>(
          create: (_) => this._contactOverviewCubit,
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
            return Container(color: backgroundColor);
          } else {
            return BlocBuilder<LocalizationCubit, LocalizationState>(
              builder: (context, state) {
                String initialRoute = '/';
                return GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                      FocusManager.instance.primaryFocus.unfocus();
                    }
                  },
                  child: MaterialApp(
                    locale: state.locale,
                    theme: ThemeData(scaffoldBackgroundColor: backgroundColor),
                    color: buttonColor,
                    debugShowCheckedModeBanner: false,
                    title: 'Tradedex',
                    initialRoute: initialRoute,
                    onGenerateRoute: RouteGenerator.generateRoute,
                    supportedLocales: [
                      Locale('en', 'US'),
                      Locale('de', 'DE'),
                    ],
                    localizationsDelegates: [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                    ],
                    localeResolutionCallback: (locale, supportedLocales) {
                      for (Locale supportedLocale in supportedLocales) {
                        bool isSupportedLanguage = supportedLocale.languageCode == locale.languageCode;
                        bool isSupportedCountry = supportedLocale.countryCode == locale.countryCode;
                        if (isSupportedLanguage && isSupportedCountry) return supportedLocale;
                      }
                      return supportedLocales.first;
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
