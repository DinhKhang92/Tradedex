import 'package:flutter/material.dart';
import 'package:tradedex/Global/Components/getPokemonImage.dart';
import 'package:tradedex/Global/GlobalConstants.dart';

class ContactWantedPrimaryListSubpage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<Contact> myContacts;
  final String idx;
  final Map pokemonNamesDict;

  final List<Contact> matchedContacts = new List<Contact>();

  ContactWantedPrimaryListSubpage(this.myContacts, this.idx, this.pokemonNamesDict) {
    findMatches();
  }

  List<Contact> findMatches() {
    this.myContacts.forEach((contact) {
      if (contact.primaryList.contains(idx)) this.matchedContacts.add(contact);
    });
    return matchedContacts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(this.idx + " " + this.pokemonNamesDict[this.idx]),
        backgroundColor: appBarColor,
      ),
      body: contactWantedPrimaryListSubpageBody(),
    );
  }

  Widget contactWantedPrimaryListSubpageBody() {
    return Container(
      color: backgroundColor,
      child: ListView.builder(
        itemCount: this.matchedContacts.length,
        itemBuilder: (context, i) {
          return Container(
            child: ListTile(
              title: Text(
                this.matchedContacts[i].accountName,
                style: TextStyle(color: textColor),
              ),
              leading: Container(
                height: 40,
                width: 40,
                decoration: new BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: getPokemonAssetImage(this.matchedContacts[i].icon),
                  ),
                ),
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
