import 'package:flutter/material.dart';
import 'package:tradedex/Contacts/Subpages/ContactOfficialCollectionSubpage.dart';
import 'package:tradedex/Contacts/Subpages/ContactPrimaryListSubpage.dart';
import 'package:tradedex/Contacts/Subpages/ContactWantedPrimaryListSubpage.dart';
import 'package:tradedex/Global/Components/copyToClipboard.dart';
import 'package:tradedex/Global/Components/getPokemonImage.dart';
import 'package:tradedex/Global/Components/loadDataFirebase.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ContactsPage extends StatefulWidget {
  final Map pokemonNamesDict;
  final Profile myProfile;
  ContactsPage(this.pokemonNamesDict, this.myProfile);

  @override
  State<StatefulWidget> createState() {
    return ContactsPageState(this.pokemonNamesDict, this.myProfile);
  }
}

class ContactsPageState extends State<ContactsPage> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController textEditControllerIdInput = TextEditingController();
  FirebaseDatabase database = FirebaseDatabase.instance;

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String validId;

  bool isSearching;
  Icon searchIcon = Icon(Icons.search);
  String searchText;

  List<String> searchResult = List<String>();
  TextEditingController textEditController = TextEditingController();

  // variables
  int navIndex;
  bool autoValidate;
  Map pokemonNamesDict;
  List<String> totalList;
  Map primaryListCounter;
  Map secondaryListCounter;

  // contacts
  List<Contact> myContacts;

  // appbar
  Widget appBarTitle;

  Profile myProfile;

  ContactsPageState(pokemonNamesDict, myProfile) {
    this.navIndex = 0;
    this.autoValidate = false;
    this.totalList = new List<String>();
    this.isSearching = false;

    this.myContacts = new List<Contact>();
    this.myProfile = myProfile;

    this.pokemonNamesDict = pokemonNamesDict;
    this.primaryListCounter = new Map();
    this.secondaryListCounter = new Map();

    this.appBarTitle = Text(languageFile['PAGE_CONTACTS']['TITLE_02']);

    this.textEditController.addListener(() {
      if (this.textEditController.text.isEmpty) {
        setState(() {
          this.isSearching = false;
          searchText = "";
        });
      } else {
        setState(() {
          this.isSearching = true;
          searchText = this.textEditController.text;
        });
      }
    });
  }

  @override
  void initState() {
    loadContactsFirebase(this.myProfile).then((contacts) {
      setState(() {
        this.myContacts = contacts;
        getTotalList();
        getWantedCounterList();
      });
    });

    super.initState();
  }

  void getTotalList() {
    this.myContacts.forEach((contact) {
      for (int i = 0; i < contact.primaryList.length; i++) {
        if (!this.totalList.contains(contact.primaryList[i])) {
          this.totalList.add(contact.primaryList[i]);
        }
      }
      for (int i = 0; i < contact.secondaryList.length; i++) {
        if (!this.totalList.contains(contact.secondaryList[i])) {
          this.totalList.add(contact.secondaryList[i]);
        }
      }
    });
  }

  void searchOperation(String searchText) {
    searchResult.clear();
    Map reversed = pokemonNamesDict.map((key, value) => MapEntry(value, key));

    if (isSearching != null) {
      // search in keys
      for (int i = 0; i < this.pokemonNamesDict.keys.length; i++) {
        String pokemon = this.pokemonNamesDict[this.pokemonNamesDict.keys.toList()[i]];
        if (pokemon.toLowerCase().contains(searchText.toLowerCase())) {
          String key = reversed[pokemon];
          for (int j = 0; j < this.myContacts.length; j++) {
            for (int k = 0; k < this.myContacts[j].primaryList.length; k++) {
              if (this.myContacts[j].primaryList[k].trim() == key) if (!searchResult.contains(key)) searchResult.add(key);
            }
          }
        }
      }
      // search in values
      for (int i = 0; i < this.pokemonNamesDict.values.length; i++) {
        String nr = reversed[this.pokemonNamesDict.values.toList()[i]];
        if (nr.contains(searchText.toLowerCase())) {
          for (int j = 0; j < this.myContacts.length; j++) {
            for (int k = 0; k < this.myContacts[j].primaryList.length; k++) {
              if (this.myContacts[j].primaryList[k].trim() == nr.trim()) if (!searchResult.contains(nr)) searchResult.add(nr);
            }
          }
        }
      }
    }
  }

  void handleSearchStart() {
    setState(() {
      isSearching = true;
    });
  }

  void handleSearchEnd() {
    setState(() {
      this.searchIcon = new Icon(
        Icons.search,
        color: iconColor,
      );
      this.appBarTitle = new Text(
        languageFile['PAGE_CONTACTS']['TITLE_02'],
        style: new TextStyle(
          color: titleColor,
        ),
      );
      isSearching = false;
      this.textEditController.clear();
    });
  }

  void searchPressed() {
    if (this.searchIcon.icon == Icons.search) {
      this.searchIcon = Icon(
        Icons.close,
        color: iconColor,
      );
      this.appBarTitle = TextField(
        autofocus: true,
        controller: this.textEditController,
        style: new TextStyle(color: iconColor),
        cursorColor: iconColor,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: iconColor)),
          prefixIcon: Icon(Icons.search, color: iconColor),
          hintText: languageFile['PAGE_CONTACTS']['SEARCH'],
          hintStyle: TextStyle(color: iconColor),
        ),
        onChanged: searchOperation,
      );
      handleSearchStart();
    } else {
      searchResult.clear();
      handleSearchEnd();
    }
  }

  void deleteContacts(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: dialogBackgroundColor,
          title: Text(
            languageFile['PAGE_CONTACTS']['DIALOG_DELETE']['TITLE'],
            style: TextStyle(color: textColor),
          ),
          content: Text(
            languageFile['PAGE_CONTACTS']['DIALOG_DELETE']['DESCRIPTION'],
            style: TextStyle(color: textColor),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                languageFile['PAGE_CONTACTS']['DIALOG_DELETE']['CANCEL'],
                style: TextStyle(color: buttonColor),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text(
                languageFile['PAGE_CONTACTS']['DIALOG_DELETE']['ACCEPT'],
                style: TextStyle(color: buttonColor),
              ),
              onPressed: () {
                setState(() {
                  this.myContacts.clear();
                  this.primaryListCounter.clear();
                  this.secondaryListCounter.clear();
                });
                saveContactsFirebase(this.myContacts, this.myProfile);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  String getCandyList() {
    String myCopyString = '';
    List<String> candyList = new List<String>.from(pokemonNamesDict.keys.toList());
    this.primaryListCounter.keys.toList().forEach((key) => candyList.remove(key));

    for (int i = 0; i < candyList.length; i++) {
      if (!candyList[i].contains('alolan')) myCopyString = myCopyString + ',' + int.parse(candyList[i]).toString();
    }
    if (myCopyString != '') myCopyString = myCopyString.substring(1);

    return myCopyString;
  }

  Widget getAppBar() {
    if (this.navIndex == 0) {
      return AppBar(
        title: Text(languageFile['PAGE_CONTACTS']['TITLE_01']),
        backgroundColor: appBarColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => deleteContacts(context),
          )
        ],
      );
    } else {
      return AppBar(
        title: this.appBarTitle,
        backgroundColor: appBarColor,
        actions: <Widget>[
          IconButton(
            icon: this.searchIcon,
            color: iconColor,
            onPressed: () => searchPressed(),
          ),
          IconButton(
            icon: Icon(MdiIcons.candycane),
            onPressed: () {
              String copyToClipBoardString = getCandyList();
              copyToClipboard(this.scaffoldKey, copyToClipBoardString);
            },
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> contactPages = [
      contactsPageBody(),
      wantedPageBody(),
    ];

    return Scaffold(
      key: this.scaffoldKey,
      floatingActionButton: Visibility(
        visible: this.navIndex == 0 ? true : false,
        child: FloatingActionButton(
          backgroundColor: buttonColor,
          child: Icon(
            Icons.add,
            color: buttonTextColor,
          ),
          onPressed: () => addContactDialog(context),
        ),
      ),
      appBar: getAppBar(),
      body: contactPages[this.navIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: backgroundColor,
          primaryColor: buttonColor,
          textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: subTextColor)),
        ),
        child: BottomNavigationBar(
          currentIndex: this.navIndex,
          fixedColor: buttonColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              title: Text('Contacts'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.donut_small),
              title: Text('Wanted'),
            ),
          ],
          onTap: (index) {
            setState(() {
              this.navIndex = index;
            });
          },
        ),
      ),
    );
  }

  void addContactDialog(BuildContext scaffoldContext) async {
    await showDialog(
      context: scaffoldContext,
      builder: (context) => AlertDialog(
        backgroundColor: backgroundColor,
        contentPadding: const EdgeInsets.all(18.0),
        content: Row(
          children: <Widget>[
            Form(
              child: Expanded(
                child: Form(
                  key: this.formKey,
                  autovalidate: this.autoValidate,
                  child: TextFormField(
                    style: TextStyle(color: textColor),
                    validator: (id) => validateTradingCode(id.trim()),
                    onSaved: (id) => this.validId = id.trim(),
                    controller: this.textEditControllerIdInput,
                    autofocus: true,
                    cursorColor: buttonColor,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: textColor)),
                      labelText: languageFile['PAGE_CONTACTS']['DIALOG_ADD']['TITLE'],
                      labelStyle: TextStyle(color: textColor),
                      hintText: '-LVePy20jxxxxxxxxxxx',
                      hintStyle: TextStyle(color: prefillTextColor),
                    ),
                  ),
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: buttonColor,
              child: IconButton(
                icon: Icon(
                  Icons.send,
                  color: buttonTextColor,
                ),
                color: iconColor,
                onPressed: () {
                  validateInputs();
                  if (this.validId != null) {
                    addContact();
                    this.validId = null;
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String validateTradingCode(String id) {
    if (id.length != 20)
      return 'invalid Trading Code';
    else if (id[0] != '-')
      return 'invalid Trading Code';
    // else if (myFriends.contains(code))
    //   return 'friend already in list';
    // else if (code == myID)
    //   return 'you cannot add yourself';
    else
      return null;
  }

  void validateInputs() {
    if (this.formKey.currentState.validate()) {
      this.formKey.currentState.save();
    } else {
      setState(() {
        this.autoValidate = true;
      });
    }
  }

  void addContact() {
    Contact newContact = new Contact();
    newContact.id = this.validId;

    database.reference().child(newContact.id).once().then((DataSnapshot snapshot) {
      // account name
      if (snapshot.value['account_name'] != null)
        newContact.accountName = snapshot.value['account_name'];
      else
        newContact.accountName = languageFile['PAGE_CONTACTS']['INVALID_NAME'];

      // icon
      if (snapshot.value['icon'] != null)
        newContact.icon = snapshot.value['icon'];
      else
        newContact.icon = '001';

      // primary list
      if (snapshot.value['myMostWantedList'] != null && snapshot.value['myMostWantedList'] != '[]')
        newContact.primaryList = snapshot.value['myMostWantedList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
      else
        newContact.primaryList = new List<String>();

      // secondary list
      if (snapshot.value['myNeedList'] != null && snapshot.value['myNeedList'] != '[]')
        newContact.secondaryList = snapshot.value['myNeedList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
      else
        newContact.secondaryList = new List<String>();

      setState(() {
        this.myContacts.add(newContact);
      });

      getTotalList();
      getWantedCounterList();

      saveContactsFirebase(this.myContacts, this.myProfile);
    });
  }

  void getWantedCounterList() {
    for (int i = 0; i < this.myContacts.length; i++) {
      for (int j = 0; j < this.myContacts[i].primaryList.length; j++) {
        this.primaryListCounter[this.myContacts[i].primaryList[j]] = 0;
      }
      for (int j = 0; j < this.myContacts[i].secondaryList.length; j++) {
        this.secondaryListCounter[this.myContacts[i].secondaryList[j]] = 0;
      }
    }

    for (int i = 0; i < this.myContacts.length; i++) {
      for (int j = 0; j < this.myContacts[i].primaryList.length; j++) {
        this.primaryListCounter[this.myContacts[i].primaryList[j]]++;
      }
      for (int j = 0; j < this.myContacts[i].secondaryList.length; j++) {
        this.secondaryListCounter[this.myContacts[i].secondaryList[j]]++;
      }
    }
  }

  Widget contactsPageBody() {
    this.myContacts.sort((a, b) => a.accountName.toString().toLowerCase().compareTo(b.accountName.toString().toLowerCase()));
    return Container(
      color: backgroundColor,
      child: ListView.separated(
        separatorBuilder: (context, index) => Container(
          child: Divider(
            color: dividerColor,
          ),
        ),
        itemCount: this.myContacts.length,
        itemBuilder: (context, i) {
          String idx = this.myContacts[i].icon;
          return Dismissible(
            key: Key(this.myContacts[i].id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: dismissibleColor,
              child: ListTile(
                title: Text(
                  languageFile['PAGE_CONTACTS']['DELETE_CONTACT'],
                  style: TextStyle(color: buttonTextColor),
                  textAlign: TextAlign.center,
                ),
                trailing: Icon(
                  Icons.delete,
                  color: buttonTextColor,
                ),
              ),
            ),
            child: Container(
              child: ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: new BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: getPokemonAssetImage(idx),
                    ),
                  ),
                ),
                title: Text(
                  this.myContacts[i].accountName,
                  style: TextStyle(color: textColor),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset('collection/ui_bg_lucky_pokemon_transparent.png'),
                      onPressed: () {},
                    ),
                    Text(
                      (this.pokemonNamesDict.length - this.myContacts[i].officialCollection.luckyList.length).toString(),
                      style: TextStyle(color: textColor),
                      textScaleFactor: 1.2,
                    ),
                    IconButton(
                      icon: Image.asset('collection/ic_shiny.png'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactOfficialCollectionSubpage(this.myContacts[i], this.pokemonNamesDict),
                          ),
                        );
                      },
                    ),
                    Text(
                      (this.pokemonNamesDict.length - this.myContacts[i].officialCollection.shinyList.length).toString(),
                      style: TextStyle(color: textColor),
                      textScaleFactor: 1.2,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: primaryListColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactPrimaryListSubpage(this.myContacts[i], this.pokemonNamesDict),
                          ),
                        );
                      },
                    ),
                    Text(
                      this.myContacts[i].primaryList.length.toString(),
                      style: TextStyle(color: textColor),
                      textScaleFactor: 1.2,
                    ),
                  ],
                ),
              ),
            ),
            onDismissed: (direction) {
              String name = this.myContacts[i].accountName;
              deleteFromCounterList(i);
              this.myContacts.removeAt(i);

              saveContactsFirebase(this.myContacts, this.myProfile);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("$name" + languageFile['PAGE_CONTACTS']['DELETE_CONTACT_SNACKBAR']),
                duration: Duration(milliseconds: 2000),
              ));
            },
          );
        },
      ),
    );
  }

  void deleteFromCounterList(int i) {
    for (int j = 0; j < this.myContacts[i].primaryList.length; j++) {
      this.primaryListCounter[this.myContacts[i].primaryList[j]]--;
      if (this.primaryListCounter[this.myContacts[i].primaryList[j]] < 1) this.primaryListCounter.remove(this.myContacts[i].primaryList[j]);
    }
    for (int j = 0; j < this.myContacts[i].secondaryList.length; j++) {
      this.secondaryListCounter[this.myContacts[i].secondaryList[j]]--;
      if (this.secondaryListCounter[this.myContacts[i].secondaryList[j]] < 1) this.secondaryListCounter.remove(this.myContacts[i].secondaryList[j]);
    }
  }

  void sortList() {
    for (int i = 0; i < this.myContacts.length; i++) {
      this.myContacts[i].primaryList.sort((a, b) => a.trim().compareTo(b.trim()));
      this.myContacts[i].secondaryList.sort((a, b) => a.trim().compareTo(b.trim()));
    }

    this.totalList.sort((a, b) => a.trim().compareTo(b.trim()));
  }

  Widget wantedPageBody() {
    sortList();
    List<dynamic> tmpList = this.primaryListCounter.keys.toList()..sort();

    return Container(
      color: backgroundColor,
      child: ListView.builder(
        itemCount: searchResult.length != 0 || textEditController.text.isNotEmpty ? this.searchResult.length : this.primaryListCounter.length,
        itemBuilder: (context, i) {
          String idx;
          searchResult.length != 0 || textEditController.text.isNotEmpty ? idx = this.searchResult.elementAt(i) : idx = tmpList.elementAt(i);
          return ListTile(
            leading: getPokemonImage(idx),
            title: Text(
              "#" + idx.split('_')[0] + ' ' + this.pokemonNamesDict[idx],
              style: TextStyle(color: textColor),
            ),
            trailing: getTrailing(idx),
          );
        },
      ),
    );
  }

  Widget getTrailing(String idx) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.favorite,
            color: primaryListColor,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactWantedPrimaryListSubpage(this.myContacts, idx, this.pokemonNamesDict)),
            );
          },
        ),
        Text(
          this.primaryListCounter[idx].toString(),
          style: TextStyle(color: textColor),
          textScaleFactor: 1.2,
        ),
      ],
    );
  }
}

//   void _updateFireBase() {
//     database.reference().child(myID).update({'myFriends': myFriends});
//   }

//   void _getContacts() async {
//     myContacts.clear();
//     String name;
//     String icon;
//     List<String> needList;
//     List<String> mostWantedList;

//     for (int i = 0; i < myFriends.length; i++) {
//       Contact contact = Contact();
//       String id = myFriends[i].trim();

//       database.reference().child(id).once().then((DataSnapshot snapshot) {
//         if (snapshot.value['account_name'] != null)
//           name = snapshot.value['account_name'];
//         else
//           name = 'no valid name';

//         if (snapshot.value['icon'] != null)
//           icon = snapshot.value['icon'];
//         else
//           icon = '001';

//         if (snapshot.value['myNeedList'] != null && snapshot.value['myNeedList'] != '[]')
//           needList = snapshot.value['myNeedList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
//         else
//           needList = List<String>();

//         if (snapshot.value['myMostWantedList'] != null && snapshot.value['myMostWantedList'] != '[]')
//           mostWantedList = snapshot.value['myMostWantedList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
//         else
//           mostWantedList = List<String>();

//         contact.name = name;
//         contact.icon = icon;
//         contact.needList = needList;
//         contact.mostWantedList = mostWantedList;
//         contact.id = id;

//         setState(() {
//           myContacts.add(contact);
//         });
//       });
//     }
//   }

// String validateTradingCode(String id) {
//   if (id.length != 20)
//     return 'invalid Trading Code';
//   // else if (code[0] != '-')
//   //   return 'invalid Trading Code';
//   // else if (myFriends.contains(code))
//   //   return 'friend already in list';
//   // else if (code == myID)
//   //   return 'you cannot add yourself';
//   else
//     return null;
// }

// bool _validateInputs() {
//   if (_formKey.currentState.validate()) {
//     _formKey.currentState.save();
//   } else {
//     setState(() {
//       _autoValidate = true;
//     });
//   }
// }

// class ContactsScreenBody extends StatefulWidget {
//   final myContacts;
//   Function _getContacts;

//   ContactsScreenBody(this.myContacts, this._getContacts);

//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return ContactsScreenBodyState(myContacts, _getContacts);
//   }
// }

// class ContactsScreenBodyState extends State<ContactsScreenBody> {
//   final FirebaseDatabase database = FirebaseDatabase.instance;
//   final myContacts;
//   Function _getContacts;

//   ContactsScreenBodyState(this.myContacts, this._getContacts);

//   String deleteID;

//   @override
//   Widget build(BuildContext context) {
//     myContacts.sort((a, b) => a.name.toString().toLowerCase().compareTo(b.name.toString().toLowerCase()));
//     return Container(
//       color: backgroundColor,
//       child: ListView.separated(
//         separatorBuilder: (context, index) => Container(
//           child: Divider(
//             color: Colors.grey[500],
//           ),
//         ),
//         itemCount: myContacts.length,
//         itemBuilder: (context, i) {
//           String idx = myContacts[i].icon;
//           return Dismissible(
//             key: Key(deleteID),
//             direction: DismissDirection.endToStart,
//             background: Container(
//                 color: redColor,
//                 child: ListTile(
//                   title:
//                       Text(myLanguage == 'en' ? "Delete Contact ..." : "Kontakt löschen ...", style: TextStyle(color: whiteColor), textAlign: TextAlign.center),
//                   trailing: Icon(
//                     Icons.delete,
//                     color: whiteColor,
//                   ),
//                 )),
//             child: Container(
//                 child: ListTile(
//               leading: Container(
//                 height: 40,
//                 width: 40,
//                 decoration: new BoxDecoration(
//                   color: Colors.grey[300],
//                   shape: BoxShape.circle,
//                   image: new DecorationImage(
//                     fit: BoxFit.scaleDown,
//                     image: _getPokemonImage(idx),
//                   ),
//                 ),
//               ),
//               title: Text(
//                 myContacts[i].name,
//                 style: TextStyle(color: textColor),
//               ),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   IconButton(
//                     icon: Icon(
//                       Icons.favorite,
//                       color: markPokemonColor,
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ContactMostWantedListScreen(myContacts[i]),
//                           ));
//                     },
//                   ),
//                   Text(
//                     "[${myContacts[i].mostWantedList.length}]",
//                     style: TextStyle(color: textColor),
//                     textScaleFactor: 1.2,
//                   ),
//                   IconButton(
//                     icon: Icon(MdiIcons.hexagon, color: Colors.amber),
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ContactNeedListScreen(myContacts[i]),
//                           ));
//                     },
//                   ),
//                   Text(
//                     "[${myContacts[i].needList.length}]",
//                     style: TextStyle(color: textColor),
//                     textScaleFactor: 1.2,
//                   ),
//                 ],
//               ),
//             )),
//             onDismissed: (direction) {
//               deleteID = myContacts[i].id;
//               setState(() {
//                 myFriends.remove(deleteID);
//                 myContacts.removeAt(i);
//               });
//               _updateFireBase();
//               Scaffold.of(context).showSnackBar(SnackBar(
//                 content: Text("Friend successfully removed."),
//                 duration: Duration(milliseconds: 2000),
//               ));
//             },
//           );
//         },
//       ),
//     );
//   }

//   void _updateFireBase() {
//     database.reference().child(myID).update({'myFriends': myFriends});
//   }

//   AssetImage _getPokemonImage(String idx) {
//     if (idx.contains('alolan') == false)
//       return AssetImage('assets_bundle/pokemon_icons_blank/$idx.png');
//     else
//       return AssetImage('assets_bundle/pokemon_icons_alolan/$idx.png');
//   }
// }

// class WantedScreenBody extends StatefulWidget {
//   final myContacts;
//   final searchResult;
//   final textEditController;
//   WantedScreenBody(this.myContacts, this.searchResult, this.textEditController);

//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return WantedScreenBodyState(myContacts, searchResult, textEditController);
//   }
// }

// class WantedScreenBodyState extends State<WantedScreenBody> {
//   final myContacts;
//   final searchResult;
//   final textEditController;
//   WantedScreenBodyState(this.myContacts, this.searchResult, this.textEditController);

//   Map<String, int> needDict = Map<String, int>();
//   Map<String, int> wantedDict = Map<String, int>();
//   List<String> totalList = List<String>();
//   List<String> needList = List<String>();
//   List<String> wantedList = List<String>();

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       _getNeedWantedList();
//     });
//   }

//   void _getNeedWantedList() {
//     needDict.clear();
//     wantedDict.clear();
//     needList.clear();
//     wantedList.clear();
//     for (int i = 0; i < myContacts.length; i++) {
//       for (int j = 0; j < myContacts[i].needList.length; j++) {
//         String idx = myContacts[i].needList[j].trim();
//         List<String> keys = needDict.keys.toList();
//         if (!keys.contains(idx)) {
//           needDict[idx] = 1;
//           if (!totalList.contains(idx)) totalList.add(idx);
//         } else {
//           int counter = needDict[idx];
//           needDict[idx] = counter + 1;
//         }
//       }
//       for (int j = 0; j < myContacts[i].mostWantedList.length; j++) {
//         String idx = myContacts[i].mostWantedList[j].trim();
//         List<String> keys = wantedDict.keys.toList();
//         if (!keys.contains(idx)) {
//           wantedDict[idx] = 1;
//           if (!totalList.contains(idx)) totalList.add(idx);
//         } else {
//           int counter = wantedDict[idx];
//           wantedDict[idx] = counter + 1;
//         }
//       }
//     }
//     needList = needDict.keys.toList();
//     wantedList = wantedDict.keys.toList();
//   }

//   Image _getPokemonImage(String idx) {
//     if (idx.contains('_alolan') == false) {
//       return Image(
//         image: AssetImage('assets_bundle/pokemon_icons_blank/$idx.png'),
//         height: 40.0,
//         width: 40.0,
//         fit: BoxFit.cover,
//       );
//     } else {
//       return Image(
//         image: AssetImage('assets_bundle/pokemon_icons_alolan/$idx.png'),
//         height: 40.0,
//         width: 40.0,
//         fit: BoxFit.cover,
//       );
//     }
//   }

//   String _getNeedNr(String idx) {
//     List<String> keysNeed = needDict.keys.toList();
//     if (keysNeed.contains(idx))
//       return needDict[idx].toString();
//     else
//       return "0";
//   }

//   String _getWantedNr(String idx) {
//     List<String> keysWanted = wantedDict.keys.toList();
//     if (keysWanted.contains(idx))
//       return wantedDict[idx].toString();
//     else
//       return "0";
//   }

//   @override
//   Widget build(BuildContext context) {
//     totalList.sort();
//     needList.sort();
//     wantedList.sort();
//     return Container(
//       color: backgroundColor,
//       child: _buildTotalList(),
//     );
//   }

//   _getItemCount() {
//     if (searchResult.length != 0 || textEditController.text.isNotEmpty)
//       return searchResult.length;
//     else if (primary == true)
//       return wantedList.length;
//     else
//       return totalList.length;
//   }

//   _getIdx(int i) {
//     if (searchResult.length != 0 || textEditController.text.isNotEmpty)
//       return searchResult[i];
//     else if (primary == true)
//       return wantedList[i];
//     else
//       return totalList[i];
//   }

// Widget _getTrailing(String idx) {
//   if (primary == true) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         IconButton(
//           icon: Icon(
//             Icons.favorite,
//             color: markPokemonColor,
//           ),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => OfferWantedScreen(myContacts, idx)),
//             );
//           },
//         ),
//         Text(
//           "[${_getWantedNr(idx)}]",
//           style: TextStyle(color: textColor),
//           textScaleFactor: 1.2,
//         ),
//       ],
//     );
//   } else {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         IconButton(
//           icon: Icon(
//             Icons.favorite,
//             color: markPokemonColor,
//           ),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => OfferWantedScreen(myContacts, idx)),
//             );
//           },
//         ),
//         Text(
//           "[${_getWantedNr(idx)}]",
//           style: TextStyle(color: textColor),
//           textScaleFactor: 1.2,
//         ),
//         IconButton(
//           icon: Icon(MdiIcons.hexagon, color: Colors.amber),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => OfferNeedScreen(myContacts, idx)),
//             );
//           },
//         ),
//         Text(
//           "[${_getNeedNr(idx)}]",
//           style: TextStyle(color: textColor),
//           textScaleFactor: 1.2,
//         ),
//       ],
//     );
//   }
// }

//   Widget _buildTotalList() {
//     return ListView.builder(
//         itemCount: _getItemCount(),
//         itemBuilder: (context, i) {
//           String idx = _getIdx(i);
//           String currPokemon = pokemonNamesDict[idx];
//           String currPokemonNr = idx;
//           if (idx.contains('alolan')) currPokemonNr = idx.split('_')[0];
//           return ListTile(
//             leading: _getPokemonImage(idx),
//             title: Text(
//               "#" + currPokemonNr + ' ' + currPokemon,
//               style: TextStyle(color: textColor),
//             ),
//             trailing: _getTrailing(idx),
//           );
//         });
//   }
// }

// class Contact {
//   String name;
//   String nickname;
//   String icon;
//   String id;
//   List<String> needList;
//   List<String> mostWantedList;
// }
