import 'package:flutter/material.dart';
import 'package:tradedex/Global/Components/getPokemonImage.dart';
import 'package:tradedex/Global/GlobalConstants.dart';

class ContactOfficialCollectionSubpage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final Contact contact;
  final Map pokemonNamesDict;

  Map pokemonNamesDictCopy;
  Map shinyDict;
  ContactOfficialCollectionSubpage(this.contact, this.pokemonNamesDict) {
    this.pokemonNamesDictCopy = new Map.from(this.pokemonNamesDict);
    this.shinyDict = new Map.from(this.pokemonNamesDict);

    getShinyList();
  }

  void getShinyList() {
    this.pokemonNamesDict.forEach((key, value) {
      if (key.contains('alolan')) {
        this.pokemonNamesDictCopy.remove(key);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.contact.accountName + languageFile['PAGE_CONTACTS']['PRIMARY_LIST_SUBPAGE']['TITLE'],
          style: TextStyle(color: titleColor),
        ),
        backgroundColor: appBarColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.content_copy,
              color: iconColor,
            ),
            onPressed: () {
              // String copyToClipBoardString = getPrimaryListString();
              // copyToClipboard(this.scaffoldKey, copyToClipBoardString);
            },
          ),
        ],
      ),
      body: contactOfficialCollectionSubpageBody(),
    );
  }

  Widget contactOfficialCollectionSubpageBody() {
    return Container(
      color: backgroundColor,
      child: GridView.builder(
        itemCount: this.pokemonNamesDictCopy.keys.length,
        padding: EdgeInsets.fromLTRB(20, 10, 5, 0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
        itemBuilder: (context, i) {
          String idx = this.pokemonNamesDictCopy.keys.toList()[i];
          return GridTile(
            child: showShiny(idx),
          );
        },
      ),
    );
  }

  Widget showShiny(String idx) {
    return Stack(
      children: <Widget>[
        Image(
          color: this.contact.officialCollection.shinyList.contains(idx) ? null : silhouetteColor,
          image: AssetImage('assets_bundle/pokemon_icons_shiny/$idx.png'),
          height: 45.0,
          width: 45.0,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
