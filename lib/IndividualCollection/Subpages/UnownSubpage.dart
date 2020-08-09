import 'package:flutter/material.dart';
import '../../Global/GlobalConstants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'Components/fillList.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';

class UnownSubpage extends StatefulWidget {
  final List<dynamic> unownList;
  final List<dynamic> unownListTotal;
  final String name;
  final Profile myProfile;
  UnownSubpage(this.unownList, this.unownListTotal, this.name, this.myProfile);

  @override
  State<StatefulWidget> createState() {
    return UnownSubpageState(this.unownList, this.unownListTotal, this.name, this.myProfile);
  }
}

class UnownSubpageState extends State<UnownSubpage> {
  List<dynamic> unownList;
  List<dynamic> unownListTotal;
  String name;
  Profile myProfile;
  UnownSubpageState(unownList, unownListTotal, name, myProfile) {
    this.unownList = unownList;
    this.unownListTotal = unownListTotal;
    this.name = name;
    this.myProfile = myProfile;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          languageFile['PAGE_INDIVIDUAL_COLLECTION']['UNOWN_SUBPAGE']['TITLE'],
          style: TextStyle(color: titleColor),
        ),
        backgroundColor: appBarColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              MdiIcons.eyeOff,
              color: iconColor,
            ),
            onPressed: () {
              setState(() {
                this.unownList.clear();
              });
              saveIndividualCollectionSingleListFirebase(this.unownList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['UNOWN']);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: iconColor,
            ),
            onPressed: () {
              setState(() {
                fillList(this.unownList, this.unownListTotal);
              });
              saveIndividualCollectionSingleListFirebase(this.unownList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['UNOWN']);
            },
          ),
        ],
      ),
      body: unownSubpageBody(),
    );
  }

  List<String> alphabet = [
    '"A"',
    '"A"',
    '"B"',
    '"B"',
    '"C"',
    '"C"',
    '"D"',
    '"D"',
    '"E"',
    '"E"',
    '"F"',
    '"F"',
    '"G"',
    '"G"',
    '"H"',
    '"H"',
    '"I"',
    '"I"',
    '"J"',
    '"J"',
    '"K"',
    '"K"',
    '"L"',
    '"L"',
    '"M"',
    '"M"',
    '"N"',
    '"N"',
    '"O"',
    '"O"',
    '"P"',
    '"P"',
    '"Q"',
    '"Q"',
    '"R"',
    '"R"',
    '"S"',
    '"S"',
    '"T"',
    '"T"',
    '"U"',
    '"U"',
    '"V"',
    '"V"',
    '"W"',
    '"W"',
    '"X"',
    '"X"',
    '"Y"',
    '"Y"',
    '"Z"',
    '"Z"',
    '"!"',
    '"!"',
    '"?"',
    '"?"'
  ];

  bool checkNeedPokemon(String idx) {
    if (this.unownList.contains(idx))
      return false;
    else
      return true;
  }

  Widget showUnown(String idx, bool needPokemon) {
    return Stack(
      children: <Widget>[
        Center(
          child: Image(
            color: needPokemon ? silhouetteColor : null,
            image: AssetImage('assets_bundle/pokemon_icons_unown/$idx'),
            fit: BoxFit.scaleDown,
          ),
        ),
        idx.contains('shiny')
            ? Image(
                alignment: Alignment(-1, -1),
                height: 30,
                width: 30,
                image: AssetImage('collection/ic_shiny.png'),
                color: secondaryListColor,
              )
            : Text(" "),
      ],
    );
  }

  Widget unownSubpageBody() {
    return Container(
      color: backgroundColor,
      child: GridView.builder(
        itemCount: this.unownListTotal.length,
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, i) {
          int letterCounter = i % 2;
          String idx = this.unownListTotal[i];
          bool needPokemon = checkNeedPokemon(idx);
          return GridTile(
            footer: Text(
              alphabet[i - letterCounter],
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor),
            ),
            child: InkResponse(
              child: showUnown(idx, needPokemon),
              onTap: () {
                setState(() {
                  needPokemon ? this.unownList.add(idx) : this.unownList.remove(idx);
                });
                saveIndividualCollectionSingleListFirebase(this.unownList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['UNOWN']);
              },
            ),
          );
        },
      ),
    );
  }
}
