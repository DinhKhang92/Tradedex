import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/pages/home/cubit/pokemon_cubit.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:tradedex/model/device.dart';
import 'package:tradedex/pages/settings/pages/language/components/language_item.dart';

class LanguagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LanguagePageState();
}

class LanguagePageState extends State<LanguagePage> with Device {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff242423),
      key: this._scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: BlocBuilder<PokemonCubit, PokemonState>(
              builder: (context, state) {
                return Container(
                  height: Device.height - Device.safeAreaTop - 77 - Device.safeAreaBottom,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 30.0,
                      mainAxisSpacing: 30.0,
                    ),
                    children: [
                      LanguageItem(
                        icon: 'assets/imgs/statue_of_liberty.png',
                        language: AppLocalizations.of(context).translate('LANGUAGES.ENGLISH'),
                        languageAcronym: AppLocalizations.of(context).translate('LANGUAGES.ENGLISH_AC'),
                        color: Color(0xffee6c4d),
                        locale: Locale('en', 'US'),
                      ),
                      LanguageItem(
                        icon: 'assets/imgs/fernsehturm_berlin.png',
                        language: AppLocalizations.of(context).translate('LANGUAGES.GERMAN'),
                        languageAcronym: AppLocalizations.of(context).translate('LANGUAGES.GERMAN_AC'),
                        color: Color(0xffffcd05),
                        locale: Locale('de', 'DE'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 12, left: 5, right: 5, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          Text(
            AppLocalizations.of(context).translate("PAGE_SETTINGS.LANGUAGES"),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Container(
            width: 48,
            height: 48,
            padding: EdgeInsets.all(8),
          ),
        ],
      ),
    );
  }
}
