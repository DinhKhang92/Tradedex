import 'package:flutter/material.dart';
import '../../Global/GlobalConstants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'Components/fillList.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';

class RegionalSubpage extends StatefulWidget {
  final List<dynamic> regionalList;
  final List<dynamic> regionalListTotal;
  final String name;
  final Profile myProfile;
  RegionalSubpage(this.regionalList, this.regionalListTotal, this.name, this.myProfile);

  @override
  State<StatefulWidget> createState() {
    return RegionalSubpageState(this.regionalList, this.regionalListTotal, this.name, this.myProfile);
  }
}

class RegionalSubpageState extends State<RegionalSubpage> {
  List<dynamic> regionalList;
  List<dynamic> regionalListTotal;
  String name;
  Profile myProfile;
  RegionalSubpageState(regionalList, regionalListTotal, name, myProfile) {
    this.regionalList = regionalList;
    this.regionalListTotal = regionalListTotal;
    this.name = name;
    this.myProfile = myProfile;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          languageFile['PAGE_INDIVIDUAL_COLLECTION']['REGIONAL_SUBPAGE']['TITLE'],
          style: TextStyle(color: titleColor),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              MdiIcons.eyeOff,
              color: iconColor,
            ),
            onPressed: () {
              setState(() {
                this.regionalList.clear();
              });
              saveIndividualCollectionSingleListFirebase(this.regionalList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['REGIONAL']);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: iconColor,
            ),
            onPressed: () {
              setState(() {
                this.regionalList = fillList(this.regionalList, this.regionalListTotal);
              });
              saveIndividualCollectionSingleListFirebase(this.regionalList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['REGIONAL']);
            },
          ),
        ],
      ),
      body: regionalSubpageBody(),
    );
  }

  Widget showRegional(String idx, bool needPokemon) {
    return Stack(
      children: <Widget>[
        Center(
          child: Image(
            color: needPokemon ? silhouetteColor : null,
            image: AssetImage('assets_bundle/pokemon_icons_regional/$idx'),
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

  bool checkNeedPokemon(String idx) {
    if (this.regionalList.contains(idx))
      return false;
    else
      return true;
  }

  Widget regionalSubpageBody() {
    return Container(
      color: backgroundColor,
      child: GridView.builder(
        itemCount: this.regionalListTotal.length,
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, i) {
          String idx = this.regionalListTotal[i];
          bool needPokemon = checkNeedPokemon(idx);
          return GridTile(
            child: InkResponse(
              child: showRegional(idx, needPokemon),
              onTap: () {
                setState(() {
                  needPokemon ? regionalList.add(idx) : regionalList.remove(idx);
                });
                saveIndividualCollectionSingleListFirebase(this.regionalList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['REGIONAL']);
              },
            ),
          );
        },
      ),
    );
  }
}
