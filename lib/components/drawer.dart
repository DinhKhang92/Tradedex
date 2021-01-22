import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/localization/app_localization.dart';

class DrawerComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DrawerComponentState();
}

class DrawerComponentState extends State<DrawerComponent> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: backgroundColor,
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
            color: backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 10),
                Container(
                  height: 40,
                  width: 40,
                  decoration: new BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: AssetImage(
                          'assets_bundle/pokemon_icons_blank/001.png'),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Khang",
                      style: TextStyle(color: textColor, fontSize: 20),
                    ),
                    SizedBox(height: 3),
                    _buildSignedInIcon(),
                    // getUserVerification(this.isSignedIn, this.myProfile.id),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: FlatButton(
              child: Chip(
                backgroundColor: buttonColor,
                label: Text(
                  AppLocalizations.of(context)
                      .translate('PAGE_DRAWER.COPY_TRADING_CODE'),
                  style: TextStyle(color: buttonTextColor),
                ),
              ),
              onPressed: () {},
              // onPressed: () => copyToClipboard(this.scaffoldKey, this.myProfile.id),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildSignedInIcon() {
    return Row(
      children: [
        Icon(
          Icons.verified_user,
          size: 15,
          color: Colors.green[800],
        ),
        // isSignedIn == false
        //     ? Icon(
        //         MdiIcons.shieldOutline,
        //         size: 15,
        //         color: Colors.red[900],
        //       )
        //     : Icon(
        //         Icons.verified_user,
        //         size: 15,
        //         color: Colors.green[800],
        //       ),
        SizedBox(width: 5),
        Text(
          "myID",
          style: TextStyle(color: subTextColor, fontSize: 13),
        )
      ],
    );
  }

  Widget _buildSignIn() {
    return Container(
      color: signInButtonColor,
      child: ListTile(
        leading: Icon(
          Icons.account_circle,
          color: drawerIconColor,
        ),
        title: Text(
          AppLocalizations.of(context).translate('PAGE_DRAWER.SIGN_IN'),
          style: TextStyle(color: textColor),
        ),
        onTap: () => Navigator.of(context).pushNamed('/signin'),
      ),
    );
  }

  Widget _buildHome() {
    return ListTile(
      leading: Icon(Icons.home, color: drawerIconColor),
      title: Text(
        AppLocalizations.of(context).translate('PAGE_DRAWER.HOME'),
        style: TextStyle(color: textColor),
      ),
      onTap: Navigator.of(context).pop,
    );
  }

  Widget _buildPrimary() {
    return ListTile(
      leading: Icon(
        Icons.favorite,
        color: drawerIconColor,
      ),
      title: Text(
        AppLocalizations.of(context).translate('PAGE_DRAWER.PRIMARY_LIST'),
        style: TextStyle(color: textColor),
      ),
      onTap: () => Navigator.of(context).pushNamed('/primary'),
    );
  }

  Widget _buildSecondary() {
    return ListTile(
      leading: Icon(
        MdiIcons.hexagon,
        color: drawerIconColor,
      ),
      title: Text(
        AppLocalizations.of(context).translate('PAGE_DRAWER.SECONDARY_LIST'),
        style: TextStyle(color: textColor),
      ),
      onTap: () => Navigator.of(context).pushNamed('/secondary'),
    );
  }

  Widget _buildOfficial() {
    return ListTile(
      leading: Icon(
        MdiIcons.pokeball,
        color: drawerIconColor,
      ),
      title: Text(
        AppLocalizations.of(context)
            .translate('PAGE_DRAWER.OFFICIAL_COLLECTION'),
        style: TextStyle(color: textColor),
      ),
      onTap: () => Navigator.of(context).pushNamed('/official'),
    );
  }

  Widget _buildIndividual() {
    return ListTile(
      leading: Icon(
        MdiIcons.bookOpen,
        color: drawerIconColor,
      ),
      title: Text(
        AppLocalizations.of(context)
            .translate('PAGE_DRAWER.INDIVIDUAL_COLLECTION'),
        style: TextStyle(color: textColor),
      ),
      onTap: () => Navigator.of(context).pushNamed('/individual'),
    );
  }

  Widget _buildContact() {
    return ListTile(
      leading: Icon(
        Icons.people,
        color: drawerIconColor,
      ),
      title: Text(
        AppLocalizations.of(context).translate('PAGE_DRAWER.CONTACTS'),
        style: TextStyle(color: textColor),
      ),
      onTap: () => Navigator.of(context).pushNamed('/contacts'),
    );
  }

  Widget _buildSettings() {
    return ListTile(
      leading: Icon(
        Icons.settings,
        color: drawerIconColor,
      ),
      title: Text(
        AppLocalizations.of(context).translate('PAGE_DRAWER.SETTINGS'),
        style: TextStyle(color: textColor),
      ),
      onTap: () => Navigator.of(context).pushNamed('/settings'),
    );
  }

  Widget _buildAbout() {
    return ListTile(
      leading: Icon(
        Icons.info_outline,
        color: drawerIconColor,
      ),
      title: Text(
        AppLocalizations.of(context).translate('PAGE_DRAWER.ABOUT'),
        style: TextStyle(color: textColor),
      ),
      onTap: () => Navigator.of(context).pushNamed('/about'),
    );
  }
}
