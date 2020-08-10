import 'package:flutter/material.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';
import '../../Global/GlobalConstants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'Components/fillList.dart';

class AlolanSubpage extends StatefulWidget {
  final List<dynamic> alolanList;
  final List<dynamic> alolanListTotal;
  final String name;
  final Profile myProfile;
  AlolanSubpage(this.alolanList, this.alolanListTotal, this.name, this.myProfile);

  @override
  State<StatefulWidget> createState() {
    return AlolanSubpageState(this.alolanList, this.alolanListTotal, this.name, this.myProfile);
  }
}

class AlolanSubpageState extends State<AlolanSubpage> {
  List<dynamic> alolanList;
  List<dynamic> alolanListTotal;
  String name;
  Profile myProfile;
  AlolanSubpageState(alolanList, alolanListTotal, key, myProfile) {
    this.alolanList = alolanList;
    this.alolanListTotal = alolanListTotal;
    this.name = key;
    this.myProfile = myProfile;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          languageFile['PAGE_INDIVIDUAL_COLLECTION']['ALOLAN_SUBPAGE']['TITLE'],
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
                this.alolanList.clear();
              });
              saveIndividualCollectionSingleListFirebase(this.alolanList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['ALOLAN']);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: iconColor,
            ),
            onPressed: () {
              setState(() {
                this.alolanList = fillList(this.alolanList, this.alolanListTotal);
              });
              saveIndividualCollectionSingleListFirebase(this.alolanList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['ALOLAN']);
            },
          ),
        ],
      ),
      body: alolanSubpageBody(),
    );
  }

  Widget showAlolan(String idx, bool needPokemon) {
    return Stack(
      children: <Widget>[
        Center(
          child: Image(
            color: needPokemon ? silhouetteColor : null,
            image: AssetImage('assets_bundle/pokemon_icons_alolan/$idx'),
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
    if (this.alolanList.contains(idx))
      return false;
    else
      return true;
  }

  Widget alolanSubpageBody() {
    return Container(
      color: backgroundColor,
      child: GridView.builder(
        itemCount: this.alolanListTotal.length,
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, i) {
          String idx = this.alolanListTotal[i];
          bool needPokemon = checkNeedPokemon(idx);
          return GridTile(
            child: InkResponse(
              child: showAlolan(idx, needPokemon),
              onTap: () {
                setState(() {
                  needPokemon ? alolanList.add(idx) : alolanList.remove(idx);
                });
                saveIndividualCollectionSingleListFirebase(this.alolanList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['ALOLAN']);
              },
            ),
          );
        },
      ),
    );
  }
}
