import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:tradedex/cubit/account_cubit.dart';
import 'package:tradedex/model/device.dart';
import 'package:tradedex/pages/settings/components/settings_list_item.dart';
import 'package:tradedex/pages/signin/cubit/signin_cubit.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> with Device {
  final String _urlPp = 'https://github.com/DinhKhang92/Tradedex/blob/master/Privacy_Policy.md';
  final String _urlToS = 'https://github.com/DinhKhang92/Tradedex/blob/master/Terms_of_Service.md';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xff242423),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            height: Device.height - Device.safeAreaTop - 73 - Device.safeAreaBottom,
            child: ListView(
              children: [
                SizedBox(height: 20),
                _buildIcon(),
                SizedBox(height: 20),
                _buildName(),
                SizedBox(height: 5),
                _buildTradingCode(),
                SizedBox(height: 30),
                SettingsListItem(
                  fn: null,
                  leadingIcon: Icons.person_outline,
                  title: AppLocalizations.of(context).translate('PAGE_SETTINGS.PROFILE'),
                  trailingIcon: Icons.arrow_forward_ios,
                ),
                SizedBox(height: 15),
                SettingsListItem(
                  fn: this._navigateToLanguagePage,
                  leadingIcon: Icons.language,
                  title: AppLocalizations.of(context).translate('PAGE_SETTINGS.LANGUAGE'),
                  trailingIcon: Icons.arrow_forward_ios,
                ),
                SizedBox(height: 15),
                SettingsListItem(
                  fn: this._navigateToFaqPage,
                  leadingIcon: Icons.help_outline,
                  title: AppLocalizations.of(context).translate('PAGE_SETTINGS.HELP_AND_SUPPORT'),
                  trailingIcon: Icons.arrow_forward_ios,
                ),
                SizedBox(height: 15),
                SettingsListItem(
                  fn: this._navigateToToS,
                  leadingIcon: Icons.article_outlined,
                  title: AppLocalizations.of(context).translate('PAGE_SETTINGS.TERMS_OF_SERVICE'),
                  trailingIcon: Icons.arrow_forward_ios,
                ),
                SizedBox(height: 15),
                SettingsListItem(
                  fn: this._navigateToPrivacy,
                  leadingIcon: Icons.security,
                  title: AppLocalizations.of(context).translate('PAGE_SETTINGS.PRIVACY_POLICY'),
                  trailingIcon: Icons.arrow_forward_ios,
                ),
                SizedBox(height: 15),
                SettingsListItem(
                  fn: this._signout,
                  leadingIcon: Icons.logout,
                  title: AppLocalizations.of(context).translate('PAGE_SETTINGS.LOGOUT'),
                  trailingIcon: null,
                ),
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
          AppLocalizations.of(context).translate('PAGE_SETTINGS.TITLE'),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        IconButton(
          onPressed: () => {},
          icon: Icon(
            Icons.circle,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget _buildIcon() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          shape: BoxShape.circle,
          border: Border.all(
            width: 1.5,
            color: Colors.white.withOpacity(0.25),
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  return Image(image: AssetImage('assets_bundle/pokemon_icons_blank/${state.icon}.png'));
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: Color(0xffee6c4d),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.edit,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildName() {
    return Align(
      alignment: Alignment.center,
      child: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          return Text(
            state.name,
            style: TextStyle(color: Colors.white, fontSize: 16),
          );
        },
      ),
    );
  }

  Widget _buildTradingCode() {
    return Align(
      alignment: Alignment.center,
      child: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          return Text(
            state.tc,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 13,
            ),
          );
        },
      ),
    );
  }

  void _navigateToLanguagePage() {
    Navigator.of(context).pushNamed('/language');
  }

  void _navigateToFaqPage() {
    Navigator.of(context).pushNamed('/faq');
  }

  void _navigateToToS() async {
    if (await canLaunch(this._urlToS)) await launch(this._urlToS);
  }

  void _navigateToPrivacy() async {
    if (await canLaunch(this._urlPp)) await launch(this._urlPp);
  }

  void _signout() {
    BlocProvider.of<SigninCubit>(context).signout();
    Navigator.of(context).pushNamed('/');
  }
}
