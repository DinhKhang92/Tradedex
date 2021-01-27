import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:tradedex/cubit/account_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DrawerComponentState();
}

class DrawerComponentState extends State<DrawerComponent> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xff242423),
        child: ListView(
          children: <Widget>[
            _buildDrawerHeader(),
            _buildSignIn(),
            _buildHome(),
            _buildPrimary(),
            _buildSecondary(),
            _buildOfficial(),
            _buildIndividual(),
            _buildContact(),
            _buildSettings(),
            _buildAbout(),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1.5,
                      color: Colors.white.withOpacity(0.25),
                    ),
                  ),
                  child: Image(
                    image: AssetImage('assets_bundle/pokemon_icons_blank/001.png'),
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<AccountCubit, AccountState>(
                      builder: (context, state) {
                        String name = state.name;
                        return Text(
                          name,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        );
                      },
                    ),
                    SizedBox(height: 3),
                    _buildTradingCode(),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: FlatButton(
              child: Chip(
                padding: EdgeInsets.only(left: 12, right: 12),
                backgroundColor: Color(0xffee6c4d),
                label: Text(
                  AppLocalizations.of(context).translate('PAGE_DRAWER.COPY_TRADING_CODE'),
                ),
              ),
              onPressed: () {},
              // onPressed: () => copyToClipboard(this.scaffoldKey, this.myProfile.id),
            ),
          ),
          // SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildTradingCode() {
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        String tc = state.tc;
        return Text(
          tc,
          style: TextStyle(color: Colors.white.withOpacity(0.65), fontSize: 13),
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }

  Widget _buildSignIn() {
    return Container(
      child: ListTile(
        leading: Icon(
          Icons.account_circle,
          color: Color(0xffee6c4d),
        ),
        title: Text(
          AppLocalizations.of(context).translate('PAGE_DRAWER.SIGN_IN'),
          style: TextStyle(color: Colors.white),
        ),
        onTap: () => Navigator.of(context).pushNamed('/'),
      ),
    );
  }

  Widget _buildHome() {
    return ListTile(
      leading: Icon(Icons.home, color: Color(0xffee6c4d)),
      title: Text(
        AppLocalizations.of(context).translate('PAGE_DRAWER.HOME'),
        style: TextStyle(color: Colors.white),
      ),
      onTap: Navigator.of(context).pop,
    );
  }

  Widget _buildPrimary() {
    return ListTile(
      leading: Icon(
        Icons.favorite,
        color: Color(0xffee6c4d),
      ),
      title: Text(
        AppLocalizations.of(context).translate('PAGE_DRAWER.PRIMARY_LIST'),
        style: TextStyle(color: Colors.white),
      ),
      onTap: () => Navigator.of(context).pushNamed('/primary'),
    );
  }

  Widget _buildSecondary() {
    return ListTile(
      leading: Icon(
        MdiIcons.hexagon,
        color: Color(0xffee6c4d),
      ),
      title: Text(
        AppLocalizations.of(context).translate('PAGE_DRAWER.SECONDARY_LIST'),
        style: TextStyle(color: Colors.white),
      ),
      onTap: () => Navigator.of(context).pushNamed('/secondary'),
    );
  }

  Widget _buildOfficial() {
    return ListTile(
      leading: Icon(
        MdiIcons.pokeball,
        color: Color(0xffee6c4d),
      ),
      title: Text(
        AppLocalizations.of(context).translate('PAGE_DRAWER.OFFICIAL_COLLECTION'),
        style: TextStyle(color: Colors.white),
      ),
      onTap: () => Navigator.of(context).pushNamed('/official'),
    );
  }

  Widget _buildIndividual() {
    return ListTile(
      leading: Icon(
        MdiIcons.bookOpen,
        color: Color(0xffee6c4d),
      ),
      title: Text(
        AppLocalizations.of(context).translate('PAGE_DRAWER.INDIVIDUAL_COLLECTION'),
        style: TextStyle(color: Colors.white),
      ),
      onTap: () => Navigator.of(context).pushNamed('/individual'),
    );
  }

  Widget _buildContact() {
    return ListTile(
      leading: Icon(
        Icons.people,
        color: Color(0xffee6c4d),
      ),
      title: Text(
        AppLocalizations.of(context).translate('PAGE_DRAWER.CONTACTS'),
        style: TextStyle(color: Colors.white),
      ),
      onTap: () => Navigator.of(context).pushNamed('/contacts'),
    );
  }

  Widget _buildSettings() {
    return ListTile(
      leading: Icon(
        Icons.settings,
        color: Color(0xffee6c4d),
      ),
      title: Text(
        AppLocalizations.of(context).translate('PAGE_DRAWER.SETTINGS'),
        style: TextStyle(color: Colors.white),
      ),
      onTap: () => Navigator.of(context).pushNamed('/settings'),
    );
  }

  Widget _buildAbout() {
    return ListTile(
      leading: Icon(
        Icons.info_outline,
        color: Color(0xffee6c4d),
      ),
      title: Text(
        AppLocalizations.of(context).translate('PAGE_DRAWER.ABOUT'),
        style: TextStyle(color: Colors.white),
      ),
      onTap: () => Navigator.of(context).pushNamed('/about'),
    );
  }
}
