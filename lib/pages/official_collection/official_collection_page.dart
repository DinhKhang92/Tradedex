import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:tradedex/pages/official_collection/pages/lucky/lucky_page.dart';
import 'package:tradedex/pages/official_collection/pages/shiny/shiny_page.dart';
import 'package:tradedex/pages/official_collection/pages/gender/gender_page.dart';
import 'package:tradedex/pages/official_collection/cubit/official_cubit.dart';

class OfficialCollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OfficialCollectionPageState();
}

class OfficialCollectionPageState extends State<OfficialCollectionPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    this._loadPokemon();
    this._loadGender();
    super.initState();
  }

  void _loadPokemon() {
    BlocProvider.of<OfficialCubit>(context).loadPokemon(context);
  }

  void _loadGender() {
    BlocProvider.of<OfficialCubit>(context).loadGender(context);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> officialPages = [
      LuckyPage(),
      ShinyPage(),
      GenderPage(),
    ];

    return DefaultTabController(
      length: officialPages.length,
      child: SafeArea(
        child: BlocBuilder<OfficialCubit, OfficialState>(
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomPadding: false,
              backgroundColor: Color(0xff242423),
              key: this._scaffoldKey,
              body: officialPages[state.navIdx],
              bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Color(0xff242423),
                  primaryColor: Color(0xffee6c4d),
                  textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Colors.white)),
                ),
                child: BottomNavigationBar(
                  currentIndex: state.navIdx,
                  onTap: (index) => BlocProvider.of<OfficialCubit>(context).setNavIdx(index),
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(MdiIcons.star),
                      label: AppLocalizations.of(context).translate('PAGE_OFFICIAL_COLLECTION.LUCKYDEX.TITLE'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(MdiIcons.flare),
                      label: AppLocalizations.of(context).translate('PAGE_OFFICIAL_COLLECTION.SHINYDEX.TITLE'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(MdiIcons.genderMaleFemale),
                      label: AppLocalizations.of(context).translate('PAGE_OFFICIAL_COLLECTION.GENDERDEX.TITLE'),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
