import 'package:flutter/material.dart';
import '../../Global/GlobalConstants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'Components/fillList.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';

class ShadowSubpage extends StatefulWidget {
  final List<dynamic> shadowList;
  final List<dynamic> shadowListTotal;
  final String name;
  final Profile myProfile;
  ShadowSubpage(this.shadowList, this.shadowListTotal, this.name, this.myProfile);

  @override
  State<StatefulWidget> createState() {
    return ShadowSubpageState(this.shadowList, this.shadowListTotal, this.name, this.myProfile);
  }
}

class ShadowSubpageState extends State<ShadowSubpage> {
  List<dynamic> shadowList;
  List<dynamic> shadowListTotal;
  String name;
  Profile myProfile;
  ShadowSubpageState(shadowList, shadowListTotal, name, myProfile) {
    this.shadowList = shadowList;
    this.shadowListTotal = shadowListTotal;
    this.name = name;
    this.myProfile = myProfile;
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          languageFile['PAGE_INDIVIDUAL_COLLECTION']['SHADOW_SUBPAGE']['TITLE'],
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
                this.shadowList.clear();
              });
              saveIndividualCollectionSingleListFirebase(this.shadowList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['SHADOW']);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: iconColor,
            ),
            onPressed: () {
              setState(() {
                fillList(this.shadowList, this.shadowListTotal);
              });
              saveIndividualCollectionSingleListFirebase(this.shadowList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['SHADOW']);
            },
          ),
        ],
      ),
      body: shadowSubpageBody(),
    );
  }

  Widget showShadow(String idx, bool needPokemon) {
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
          image: AssetImage('collection/ic_shadow.png'),
        )
      ],
    );
  }

  bool checkNeedPokemon(String idx) {
    if (this.shadowList.contains(idx))
      return false;
    else
      return true;
  }

  shadowSubpageBody() {
    return Container(
      color: backgroundColor,
      child: GridView.builder(
        itemCount: this.shadowListTotal.length,
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
        itemBuilder: (context, i) {
          String idx = this.shadowListTotal[i];
          bool needPokemon = checkNeedPokemon(idx);
          return GridTile(
            child: InkResponse(
              child: showShadow(idx, needPokemon),
              onTap: () {
                setState(() {
                  needPokemon ? shadowList.add(idx) : shadowList.remove(idx);
                });
                saveIndividualCollectionSingleListFirebase(this.shadowList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['SHADOW']);
              },
            ),
          );
        },
      ),
    );
  }
}
