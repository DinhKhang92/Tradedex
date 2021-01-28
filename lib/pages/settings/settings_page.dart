import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:tradedex/cubit/account_cubit.dart';
import 'package:tradedex/model/device.dart';
import 'package:tradedex/pages/settings/components/settings_list_item.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> with Device {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xff242423),
        key: this._scaffoldKey,
        body: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildHeader(),
        Container(
          padding: EdgeInsets.only(left: 8, right: 8),
          height: Device.height - Device.safeAreaHeight - 73,
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
                fn: null,
                leadingIcon: Icons.language,
                title: AppLocalizations.of(context).translate('PAGE_SETTINGS.LANGUAGE'),
                trailingIcon: Icons.arrow_forward_ios,
              ),
              SizedBox(height: 15),
              SettingsListItem(
                fn: null,
                leadingIcon: Icons.help_outline,
                title: AppLocalizations.of(context).translate('PAGE_SETTINGS.HELP_AND_SUPPORT'),
                trailingIcon: Icons.arrow_forward_ios,
              ),
              SizedBox(height: 15),
              SettingsListItem(
                fn: null,
                leadingIcon: Icons.article_outlined,
                title: AppLocalizations.of(context).translate('PAGE_SETTINGS.TERMS_OF_SERVICE'),
                trailingIcon: Icons.arrow_forward_ios,
              ),
              SizedBox(height: 15),
              SettingsListItem(
                fn: null,
                leadingIcon: Icons.security,
                title: AppLocalizations.of(context).translate('PAGE_SETTINGS.PRIVACY_POLICY'),
                trailingIcon: Icons.arrow_forward_ios,
              ),
              SizedBox(height: 15),
              SettingsListItem(
                fn: null,
                leadingIcon: Icons.logout,
                title: AppLocalizations.of(context).translate('PAGE_SETTINGS.LOGOUT'),
                trailingIcon: null,
              ),
            ],
          ),
        )
      ],
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

  Widget _buildCopyTradingCode() {
    return Center(
      child: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          return FlatButton(
            child: Chip(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              backgroundColor: Color(0xffee6c4d),
              label: Text(
                AppLocalizations.of(context).translate('PAGE_DRAWER.COPY_TRADING_CODE'),
              ),
            ),
            onPressed: () => _copyToClipboard(state.tc),
          );
        },
      ),
    );
  }

  void _copyToClipboard(String copyString) {
    Clipboard.setData(ClipboardData(text: copyString));
    this._scaffoldKey.currentState.showSnackBar(_buildSnackbar());
  }

  Widget _buildSnackbar() {
    return SnackBar(
      content: Text(AppLocalizations.of(context).translate('PAGE_PRIMARY_LIST.COPY_TO_CLIPBOARD')),
    );
  }
}
