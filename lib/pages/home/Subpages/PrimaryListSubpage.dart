import 'package:flutter/material.dart';
import 'package:tradedex/Global/Components/copyToClipboard.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tradedex/pages/home/Subpages/SecondaryListSubpage.dart';
import 'dart:async';
import 'package:tradedex/Global/Components/getPokemonImage.dart';
import 'package:tradedex/Global/Components/Dialogs/deleteDialog.dart';

class PrimaryListSubpage extends StatefulWidget {
  final Profile myProfile;
  final Map pokemonNamesDict;
  PrimaryListSubpage(this.myProfile, this.pokemonNamesDict);

  @override
  State<StatefulWidget> createState() {
    return PrimaryListSubpageState(this.myProfile, this.pokemonNamesDict);
  }
}

class PrimaryListSubpageState extends State<PrimaryListSubpage> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  GlobalKey<ScaffoldState> scaffoldKey;

  Profile myProfile;
  Map pokemonNamesDict;
  Map returnData;

  PrimaryListSubpageState(myProfile, pokemonNamesDict) {
    this.myProfile = myProfile;
    this.pokemonNamesDict = pokemonNamesDict;
    this.database = FirebaseDatabase.instance;
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  String getPrimaryListString() {
    String myCopyString = '';
    for (int i = 0; i < this.myProfile.primaryList.length; i++) {
      if (!this.myProfile.primaryList[i].contains('alolan'))
        myCopyString = myCopyString +
            ',' +
            int.parse(this.myProfile.primaryList[i]).toString();
    }
    if (myCopyString != '') myCopyString = myCopyString.substring(1);

    return myCopyString;
  }

  void goToSecondaryListSubpage() async {
    final result = Navigator.of(context).push(
      MaterialPageRoute<Profile>(
        builder: (context) =>
            SecondaryListSubpage(this.myProfile, this.pokemonNamesDict),
      ),
    );

    setState(() {
      result.then((profile) {
        this.myProfile = profile;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    sortPrimaryList();
    return Scaffold(
      backgroundColor: backgroundColor,
      key: this.scaffoldKey,
      appBar: AppBar(
        title: Text(languageFile['PAGE_PRIMARY_LIST']['TITLE']),
        backgroundColor: appBarColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
              color: iconColor,
            ),
            onPressed: () {
              showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                          deleteDialog(context, this.myProfile.primaryList))
                  .then((pokemonList) {
                setState(() {
                  this.myProfile.primaryList = pokemonList;
                });
                savePokemonListsFirebase(myProfile);
              });
            },
          ),
          IconButton(
            icon: Icon(
              MdiIcons.hexagon,
              color: iconColor,
            ),
            onPressed: () {
              goToSecondaryListSubpage();
            },
          ),
          IconButton(
            icon: Icon(
              Icons.content_copy,
              color: iconColor,
            ),
            onPressed: () {
              String copyToClipBoardString = getPrimaryListString();
              copyToClipboard(this.scaffoldKey, copyToClipBoardString);
            },
          ),
        ],
      ),
      body: buildPrimaryList(context),
    );
  }

  Widget buildPrimaryList(context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, this.myProfile);
        return new Future(() => false);
      },
      child: Container(
        color: backgroundColor,
        child: ListView.builder(
          itemCount: this.myProfile.primaryList.length,
          itemBuilder: (context, i) {
            String idx = this.myProfile.primaryList[i];
            return buildRowPokemon(idx);
          },
        ),
      ),
    );
  }

  Widget buildRowPokemon(String idx) {
    String currPokemon = this.pokemonNamesDict[idx];
    String currPokemonNr = idx;
    if (idx.contains('alolan')) {
      currPokemonNr = idx.split('_')[0];
    }
    return Container(
      child: ListTile(
        title: Text(
          "#" + currPokemonNr + ' ' + currPokemon,
          style: TextStyle(color: textColor),
        ),
        leading: getPokemonImage(idx),
        trailing: Icon(
          Icons.favorite,
          color: primaryListColor,
        ),
        onTap: () {
          setState(() {
            this.myProfile.primaryList.remove(idx);
          });
          savePokemonListsFirebase(myProfile);
          // _saveMyMostWantedList();
        },
      ),
    );
  }

  void sortPrimaryList() {
    List<int> helpList = List<int>();
    List<String> helpAlolanList = List<String>();
    List<String> helpMyMostWantedList = List<String>();

    for (int i = 0; i < this.myProfile.primaryList.length; i++) {
      if (!this.myProfile.primaryList[i].contains('alolan'))
        helpList.add(int.parse(this.myProfile.primaryList[i]));
      else {
        helpAlolanList.add(this.myProfile.primaryList[i].split('_')[0]);
        int alolanNr = int.parse(this.myProfile.primaryList[i].split('_')[0]);
        helpList.add(alolanNr);
      }
    }

    helpList.sort();
    for (int i = 0; i < helpList.length; i++) {
      helpMyMostWantedList.add(helpList[i].toString());
    }
    for (int i = 0; i < helpAlolanList.length; i++) {
      for (int j = 0; j < helpMyMostWantedList.length; j++) {
        if (helpAlolanList[i].trim() ==
            helpMyMostWantedList[j].padLeft(3, '0')) {
          helpMyMostWantedList[j] = helpAlolanList[i].trim() + '_alolan';
          break;
        }
      }
    }
    this.myProfile.primaryList = helpMyMostWantedList;
    for (int i = 0; i < this.myProfile.primaryList.length; i++) {
      this.myProfile.primaryList[i] =
          this.myProfile.primaryList[i].padLeft(3, '0');
    }
  }
}
