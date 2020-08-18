import 'package:flutter/material.dart';
import 'package:tradedex/Global/Components/copyToClipboard.dart';
import 'package:tradedex/Global/Components/getPokemonImage.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../Global/GlobalConstants.dart';

class ContactSecondaryListSubpage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final Contact contact;
  final Map pokemonNamesDict;

  ContactSecondaryListSubpage(this.contact, this.pokemonNamesDict) {
    sortList();
  }

  String getSecondaryListString() {
    String myCopyString = '';
    for (int i = 0; i < this.contact.secondaryList.length; i++) {
      if (!this.contact.secondaryList[i].contains('alolan')) myCopyString = myCopyString + ',' + int.parse(this.contact.secondaryList[i]).toString();
    }
    if (myCopyString != '') myCopyString = myCopyString.substring(1);

    return myCopyString;
  }

  void sortList() {
    this.contact.secondaryList.sort((a, b) => a.trim().compareTo(b.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          this.contact.accountName + languageFile['PAGE_CONTACTS']['SECONDARY_LIST_SUBPAGE']['TITLE'],
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
              String copyToClipBoardString = getSecondaryListString();
              copyToClipboard(this.scaffoldKey, copyToClipBoardString);
            },
          ),
        ],
      ),
      body: contactSecondaryListSubpageBody(),
    );
  }

  Widget contactSecondaryListSubpageBody() {
    return Container(
      color: backgroundColor,
      child: ListView.builder(
        itemCount: this.contact.secondaryList.length,
        itemBuilder: (context, i) {
          String idx = this.contact.secondaryList[i].trim();
          return Container(
            child: ListTile(
              title: Text(
                "#" + idx.split('_')[0] + ' ' + this.pokemonNamesDict[idx],
                style: TextStyle(color: textColor),
              ),
              leading: getPokemonImage(idx),
              trailing: Icon(
                MdiIcons.hexagon,
                color: secondaryListColor,
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
