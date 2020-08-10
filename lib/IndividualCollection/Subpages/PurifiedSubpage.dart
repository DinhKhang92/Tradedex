import 'package:flutter/material.dart';
import '../../Global/GlobalConstants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'Components/fillList.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';

class PurifiedSubpage extends StatefulWidget {
  final List<dynamic> purifiedList;
  final List<dynamic> purifiedListTotal;
  final String name;
  final Profile myProfile;
  PurifiedSubpage(this.purifiedList, this.purifiedListTotal, this.name, this.myProfile);

  @override
  State<StatefulWidget> createState() {
    return PurifiedSubpageState(this.purifiedList, this.purifiedListTotal, this.name, this.myProfile);
  }
}

class PurifiedSubpageState extends State<PurifiedSubpage> {
  List<dynamic> purifiedList;
  List<dynamic> purifiedListTotal;
  GlobalKey<ScaffoldState> scaffoldKey;
  String name;
  Profile myProfile;
  PurifiedSubpageState(purifiedList, purifiedListTotal, name, myProfile) {
    this.purifiedList = purifiedList;
    this.purifiedListTotal = purifiedListTotal;
    this.name = name;
    this.myProfile = myProfile;
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: this.scaffoldKey,
      appBar: AppBar(
        title: Text(
          languageFile['PAGE_INDIVIDUAL_COLLECTION']['PURIFIED_SUBPAGE']['TITLE'],
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
                this.purifiedList.clear();
              });
              saveIndividualCollectionSingleListFirebase(this.purifiedList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['PURIFIED']);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: iconColor,
            ),
            onPressed: () {
              setState(() {
                fillList(this.purifiedList, this.purifiedListTotal);
              });
              saveIndividualCollectionSingleListFirebase(this.purifiedList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['PURIFIED']);
            },
          ),
        ],
      ),
      body: purifiedSubpageBody(),
    );
  }

  Widget showPurified(String idx, bool needPokemon) {
    return Stack(
      children: <Widget>[
        Center(
          child: Image(
            color: needPokemon ? silhouetteColor : null,
            image: AssetImage('assets_bundle/pokemon_icons_blank/$idx'),
            height: 45.0,
            width: 45.0,
            fit: BoxFit.cover,
          ),
        ),
        Image(
          alignment: Alignment(-1, -1),
          height: 30,
          width: 30,
          image: AssetImage('collection/ic_purified.png'),
        )
      ],
    );
  }

  bool checkNeedPokemon(String idx) {
    if (this.purifiedList.contains(idx))
      return false;
    else
      return true;
  }

  Widget purifiedSubpageBody() {
    return Container(
      color: backgroundColor,
      child: GridView.builder(
        itemCount: this.purifiedListTotal.length,
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
        itemBuilder: (context, i) {
          String idx = this.purifiedListTotal[i];
          bool needPokemon = checkNeedPokemon(idx);
          return GridTile(
            child: InkResponse(
              child: showPurified(idx, needPokemon),
              onTap: () {
                setState(() {
                  needPokemon ? purifiedList.add(idx) : purifiedList.remove(idx);
                });
                saveIndividualCollectionSingleListFirebase(this.purifiedList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['PURIFIED']);
              },
            ),
          );
        },
      ),
    );
  }
}
