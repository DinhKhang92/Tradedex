import 'package:flutter/material.dart';
import 'package:tradedex/Global/Components/copyToClipboard.dart';
import 'package:tradedex/Global/Components/getPokemonImage.dart';
import 'package:tradedex/Global/GlobalConstants.dart';

class ContactPrimaryListSubpage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final Contact contact;
  final Map pokemonNamesDict;

  ContactPrimaryListSubpage(this.contact, this.pokemonNamesDict) {
    sortList();
  }

  String getPrimaryListString() {
    String myCopyString = '';
    for (int i = 0; i < this.contact.primaryList.length; i++) {
      if (!this.contact.primaryList[i].contains('alolan')) myCopyString = myCopyString + ',' + int.parse(this.contact.primaryList[i]).toString();
    }
    if (myCopyString != '') myCopyString = myCopyString.substring(1);

    return myCopyString;
  }

  void sortList() {
    this.contact.primaryList.sort((a, b) => a.trim().compareTo(b.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
              String copyToClipBoardString = getPrimaryListString();
              copyToClipboard(this.scaffoldKey, copyToClipBoardString);
            },
          ),
        ],
      ),
      body: contactPrimaryListSubpageBody(),
    );
  }

  Widget contactPrimaryListSubpageBody() {
    return Container(
      color: backgroundColor,
      child: ListView.builder(
        itemCount: this.contact.primaryList.length,
        itemBuilder: (context, i) {
          String idx = this.contact.primaryList[i].trim();
          return Container(
            child: ListTile(
              title: Text(
                "#" + idx.split('_')[0] + ' ' + this.pokemonNamesDict[idx],
                style: TextStyle(color: textColor),
              ),
              leading: getPokemonImage(idx),
              trailing: Icon(
                Icons.favorite,
                color: primaryListColor,
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
