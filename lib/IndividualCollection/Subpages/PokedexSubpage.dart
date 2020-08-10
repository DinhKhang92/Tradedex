import 'package:flutter/material.dart';
import '../../Global/GlobalConstants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'Components/fillList.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';

class PokedexSubpage extends StatefulWidget {
  final List<dynamic> pokedexList;
  final List<dynamic> pokedexListTotal;
  final String name;
  final Profile myProfile;
  PokedexSubpage(this.pokedexList, this.pokedexListTotal, this.name, this.myProfile);

  @override
  State<StatefulWidget> createState() {
    return PokedexSubpageState(this.pokedexList, this.pokedexListTotal, this.name, this.myProfile);
  }
}

class PokedexSubpageState extends State<PokedexSubpage> {
  List<dynamic> pokedexList;
  List<dynamic> pokedexListTotal;
  String name;
  Profile myProfile;
  PokedexSubpageState(pokedexList, pokedexListTotal, name, myProfile) {
    this.pokedexList = pokedexList;
    this.pokedexListTotal = pokedexListTotal;
    this.name = name;
    this.myProfile = myProfile;
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          languageFile['PAGE_INDIVIDUAL_COLLECTION']['POKEDEX_SUBPAGE']['TITLE'],
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
                this.pokedexList.clear();
              });
              saveIndividualCollectionSingleListFirebase(this.pokedexList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['POKEDEX']);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: iconColor,
            ),
            onPressed: () {
              setState(() {
                fillList(this.pokedexList, this.pokedexListTotal);
              });
              saveIndividualCollectionSingleListFirebase(this.pokedexList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['POKEDEX']);
            },
          ),
        ],
      ),
      body: pokedexSubpageBody(),
    );
  }

  Widget showPokedex(String idx, bool needPokemon) {
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
        )
      ],
    );
  }

  bool checkNeedPokemon(String idx) {
    if (this.pokedexList.contains(idx))
      return false;
    else
      return true;
  }

  pokedexSubpageBody() {
    return Container(
      color: backgroundColor,
      child: GridView.builder(
        itemCount: this.pokedexListTotal.length,
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
        itemBuilder: (context, i) {
          String idx = this.pokedexListTotal[i];
          bool needPokemon = checkNeedPokemon(idx);
          return GridTile(
            child: InkResponse(
              child: showPokedex(idx, needPokemon),
              onTap: () {
                setState(() {
                  needPokemon ? pokedexList.add(idx) : pokedexList.remove(idx);
                });
                saveIndividualCollectionSingleListFirebase(this.pokedexList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['POKEDEX']);
              },
            ),
          );
        },
      ),
    );
  }
}
