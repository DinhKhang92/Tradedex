import 'package:flutter/material.dart';
import '../../Global/GlobalConstants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'Components/fillList.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';

class GalarianSubpage extends StatefulWidget {
  final List<dynamic> galarianList;
  final List<dynamic> galarianListTotal;
  final String name;
  final Profile myProfile;
  GalarianSubpage(this.galarianList, this.galarianListTotal, this.name, this.myProfile);

  @override
  State<StatefulWidget> createState() {
    return GalarianSubpageState(this.galarianList, this.galarianListTotal, this.name, this.myProfile);
  }
}

class GalarianSubpageState extends State<GalarianSubpage> {
  List<dynamic> galarianList;
  List<dynamic> galarianListTotal;
  String name;
  Profile myProfile;
  GalarianSubpageState(galarianList, galarianListTotal, name, myProfile) {
    this.galarianList = galarianList;
    this.galarianListTotal = galarianListTotal;
    this.name = name;
    this.myProfile = myProfile;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          languageFile['PAGE_INDIVIDUAL_COLLECTION']['GALARIAN_SUBPAGE']['TITLE'],
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
                this.galarianList.clear();
              });
              saveIndividualCollectionSingleListFirebase(this.galarianList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['GALARIAN']);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: iconColor,
            ),
            onPressed: () {
              setState(() {
                this.galarianList = fillList(this.galarianList, this.galarianListTotal);
              });
              saveIndividualCollectionSingleListFirebase(this.galarianList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['GALARIAN']);
            },
          ),
        ],
      ),
      body: galarianSubpageBody(),
    );
  }

  Widget showGalarian(String idx, bool needPokemon) {
    return Stack(
      children: <Widget>[
        Center(
          child: Image(
            color: needPokemon ? silhouetteColor : null,
            image: AssetImage('assets_bundle/pokemon_icons_galarian/$idx'),
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
    if (this.galarianList.contains(idx))
      return false;
    else
      return true;
  }

  galarianSubpageBody() {
    return Container(
      color: backgroundColor,
      child: GridView.builder(
        itemCount: this.galarianListTotal.length,
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, i) {
          String idx = this.galarianListTotal[i];
          bool needPokemon = checkNeedPokemon(idx);
          return GridTile(
            child: InkResponse(
              child: showGalarian(idx, needPokemon),
              onTap: () {
                setState(() {
                  needPokemon ? galarianList.add(idx) : galarianList.remove(idx);
                });
                saveIndividualCollectionSingleListFirebase(this.galarianList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['GALARIAN']);
              },
            ),
          );
        },
      ),
    );
  }
}
