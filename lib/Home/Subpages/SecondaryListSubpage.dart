import 'package:flutter/material.dart';
import 'package:tradedex/Global/Components/copyToClipboard.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:async';
import 'package:tradedex/Global/Components/getPokemonImage.dart';
import 'package:tradedex/Global/Components/Dialogs/deleteDialog.dart';

class SecondaryListSubpage extends StatefulWidget {
  final Profile myProfile;
  final Map pokemonNamesDict;
  SecondaryListSubpage(this.myProfile, this.pokemonNamesDict);

  @override
  State<StatefulWidget> createState() {
    return SecondaryListSubpageState(this.myProfile, this.pokemonNamesDict);
  }
}

class SecondaryListSubpageState extends State<SecondaryListSubpage> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  GlobalKey<ScaffoldState> scaffoldKey;

  Profile myProfile;
  Map pokemonNamesDict;

  SecondaryListSubpageState(myProfile, pokemonNamesDict) {
    this.myProfile = myProfile;
    this.pokemonNamesDict = pokemonNamesDict;
    this.database = FirebaseDatabase.instance;
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  String getSecondaryListString() {
    String myCopyString = '';
    for (int i = 0; i < this.myProfile.secondaryList.length; i++) {
      if (!this.myProfile.secondaryList[i].contains('alolan')) myCopyString = myCopyString + ',' + int.parse(this.myProfile.secondaryList[i]).toString();
//      else {
//        myCopyString = myCopyString+',alola&'+int.parse(prefix0.myMostWantedList[i].split('_')[0]).toString();
//      }
    }
    if (myCopyString != '') myCopyString = myCopyString.substring(1);

    return myCopyString;
  }

  @override
  Widget build(BuildContext context) {
    sortPrimaryList();
    return Scaffold(
      key: this.scaffoldKey,
      appBar: AppBar(
        title: Text(languageFile['PAGE_SECONDARY_LIST']['TITLE']),
        backgroundColor: appBarColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
              color: iconColor,
            ),
            onPressed: () {
              showDialog(context: context, barrierDismissible: false, builder: (context) => deleteDialog(context, this.myProfile.secondaryList)).then((pokemonList) {
                setState(() {
                  this.myProfile.secondaryList = pokemonList;
                });
                savePokemonListsFirebase(myProfile);
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.content_copy,
              color: iconColor,
            ),
            onPressed: () {
              String copyToClipBoardString = getSecondaryListString();
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
          itemCount: this.myProfile.secondaryList.length,
          itemBuilder: (context, i) {
            String idx = this.myProfile.secondaryList[i];
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
          MdiIcons.hexagon,
          color: secondaryListColor,
        ),
        onTap: () {
          setState(() {
            this.myProfile.secondaryList.remove(idx);
            // _updateFireBase();
            // _saveMyMostWantedList();
          });
          savePokemonListsFirebase(myProfile);
        },
      ),
    );
  }

  void sortPrimaryList() {
    List<int> helpList = List<int>();
    List<String> helpAlolanList = List<String>();
    List<String> helpMyMostWantedList = List<String>();

    for (int i = 0; i < this.myProfile.secondaryList.length; i++) {
      if (!this.myProfile.secondaryList[i].contains('alolan'))
        helpList.add(int.parse(this.myProfile.secondaryList[i]));
      else {
        helpAlolanList.add(this.myProfile.secondaryList[i].split('_')[0]);
        int alolanNr = int.parse(this.myProfile.secondaryList[i].split('_')[0]);
        helpList.add(alolanNr);
      }
    }

    helpList.sort();
    for (int i = 0; i < helpList.length; i++) {
      helpMyMostWantedList.add(helpList[i].toString());
    }
    for (int i = 0; i < helpAlolanList.length; i++) {
      for (int j = 0; j < helpMyMostWantedList.length; j++) {
        if (helpAlolanList[i].trim() == helpMyMostWantedList[j].padLeft(3, '0')) {
          helpMyMostWantedList[j] = helpAlolanList[i].trim() + '_alolan';
          break;
        }
      }
    }
    this.myProfile.secondaryList = helpMyMostWantedList;
    for (int i = 0; i < this.myProfile.secondaryList.length; i++) {
      this.myProfile.secondaryList[i] = this.myProfile.secondaryList[i].padLeft(3, '0');
    }
  }

  // void _updateFireBase() {
  //   database.reference().child(myID).update({'myMostWantedList': myMostWantedList.toString()});
  // }
}
