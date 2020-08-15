import 'package:tradedex/About/AboutPage.dart';
import 'package:tradedex/Contacts/ContactsPage.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';
import 'package:tradedex/Global/Components/setColorTheme.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:tradedex/Global/Components/drawer.dart';

import 'package:tradedex/Home/Subpages/PrimaryListSubpage.dart';
import 'package:tradedex/Home/Subpages/SecondaryListSubpage.dart';
import 'package:tradedex/Settings/SettingsPage.dart';
import '../Global/Components/getPokemonImage.dart';
import 'package:tradedex/Global/Components/copyToClipboard.dart';
import 'package:tradedex/SignIn/SignInPage.dart';
import 'package:tradedex/OfficialCollection/OfficialCollectionPage.dart';
import 'package:tradedex/IndividualCollection/IndividualCollectionPage.dart';

import 'dart:io' show Platform;

class HomePage extends StatefulWidget {
  final Profile myProfile;

  HomePage(this.myProfile);

  @override
  State<StatefulWidget> createState() {
    return HomePageState(this.myProfile);
  }
}

class HomePageState extends State<HomePage> {
  // function variables
  FirebaseDatabase database;
  String searchText;
  bool isSearching;
  List<String> searchResult;
  bool isSignedIn;
  TextEditingController textEditController;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<DrawerControllerState> drawerKey;

  // profile
  Profile myProfile;

  // widgets
  Widget appBarTitle;
  Icon searchIcon;

  // pokemon data
  Map pokemonNamesDict;
  List<dynamic> pokemonNamesDictKeys;
  List<dynamic> pokemonNamesDictValues;
  List<dynamic> pokemonNamesBlankDictKeys;

  HomePageState(myProfile) {
    // profile
    this.myProfile = myProfile;

    // function variables
    this.isSearching = false;
    this.isSignedIn = false;
    this.searchResult = List<String>();
    this.textEditController = new TextEditingController();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    this.drawerKey = new GlobalKey<DrawerControllerState>();
    this.database = FirebaseDatabase.instance;

    // widgets
    this.searchIcon = Icon(Icons.search);
    this.appBarTitle = Text("Tradedex");

    // pokemon data
    this.pokemonNamesDict = new Map();
    this.pokemonNamesDictKeys = new List<dynamic>();
    this.pokemonNamesDictValues = new List<dynamic>();
    this.pokemonNamesBlankDictKeys = new List<dynamic>();

    // searching function
    textEditController.addListener(() {
      if (textEditController.text.isEmpty) {
        setState(() {
          isSearching = false;
          searchText = "";
        });
      } else {
        setState(() {
          isSearching = true;
          searchText = textEditController.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this.scaffoldKey,
      appBar: AppBar(
        title: this.appBarTitle,
        backgroundColor: appBarColor,
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: iconColor,
          onPressed: () {
            setState(() {
              this.scaffoldKey.currentState.openDrawer();
            });
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: searchIcon,
            color: iconColor,
            onPressed: () => handleSearchEvent(),
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            color: iconColor,
            onPressed: () => goToPrimaryListSubpage(context),
          ),
          PopupMenuButton<String>(
            onSelected: selectedGen,
            itemBuilder: (BuildContext context) {
              return getGens().map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: buildDrawer(context),
      body: buildPokemonMainPage(),
    );
  }

  List<String> getGens() {
    List<String> genList = new List<String>();
    languageFile['PAGE_HOME']['GENS'].forEach((key, value) => genList.add(value));
    return genList;
  }

  void goToPrimaryListSubpage(context) async {
    final result = Navigator.of(context).push(
      MaterialPageRoute<Profile>(
        builder: (context) => PrimaryListSubpage(this.myProfile, this.pokemonNamesDict),
      ),
    );

    result.then((resultProfile) {
      setState(() {
        this.myProfile = resultProfile;
      });
    });
  }

  void goToSecondaryListSubpage(context) async {
    final result = Navigator.of(context).push(
      MaterialPageRoute<Profile>(
        builder: (context) => SecondaryListSubpage(this.myProfile, this.pokemonNamesDict),
      ),
    );

    result.then((resultProfile) {
      setState(() {
        this.myProfile = resultProfile;
      });
    });
  }

  void initState() {
    super.initState();
    // loadMyProfile();
    // loadIndividualCollection();
    // getIndividualCollectionFileNames();
    getUser();
  }

  void getUser() async {
    return await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        user != null ? this.isSignedIn = true : this.isSignedIn = false;
      });
    });
  }

  Future<String> loadPokemonNames() async {
    String jsonData;
    if (selectedLanguage == 'en') {
      jsonData = await rootBundle.loadString('json/pokemon_names_eng.json');
    } else if (selectedLanguage == 'de') {
      jsonData = await rootBundle.loadString('json/pokemon_names_ger.json');
    }

    this.pokemonNamesDict = jsonDecode(jsonData);
    this.pokemonNamesDictKeys = this.pokemonNamesDict.keys.toList();
    this.pokemonNamesDictValues = this.pokemonNamesDict.values.toList();

    List<String> arr = List<String>();
    this.pokemonNamesDictKeys.forEach((dynamic key) {
      if (!key.contains('alolan')) arr.add(key);
    });

    this.pokemonNamesBlankDictKeys = arr;

    return jsonData;
  }

//   void loadMyProfile() async {
//     print("load Profile ...");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     setState(() {
//       myID = prefs.getString('myID') ?? database.reference().push().key;
//       myAccountName = prefs.getString('myAccountName') ?? 'Trainer xy';
//       myIcon = prefs.getString('icon') ?? '132';
//       myNeedList = prefs.getStringList('myNeedList') ?? [];
//       myMostWantedList = prefs.getStringList('myMostWantedList') ?? [];
//       myLanguage = prefs.getString('language') ?? 'en';
//       myClassicTheme = prefs.getBool('theme') ?? false;
//       myVersion = packageInfo.version;

//       if (myClassicTheme) {
//         redColor = Colors.grey[800];
//         listTileColor = Colors.black87;
//         textColor = Colors.white;
//         markBorderColor = Colors.white70;
//         markPokemonColor = Colors.red[900];
//         subTextColor = Colors.white54;
//         captionTextColor = Colors.white54;
//         dividerColor = Colors.grey[600];
//         buttonColor = Colors.grey[600];
//         iconColor = Colors.white;
//         drawerColor = Colors.black87;
//         backgroundColor = Colors.black87;
//         bottomNavBarColor = Colors.grey[800];
//         bottomNavBarIconColor = Colors.white;
//       } else {
//         redColor = Colors.red[900];
//         listTileColor = Colors.white;
//         textColor = Colors.black;
//         markBorderColor = null;
//         markPokemonColor = Colors.red;
//         subTextColor = Colors.grey[700];
//         captionTextColor = Colors.grey[600];
//         dividerColor = Colors.grey[500];
//         buttonColor = Colors.red[200];
//         iconColor = Colors.grey[600];
//         drawerColor = Colors.grey[100];
//         backgroundColor = Colors.white;
//         bottomNavBarColor = Colors.grey[100];
//         bottomNavBarIconColor = Colors.red[900];
//       }

//       prefs.setString('myID', myID);
//       prefs.setString('myAccountName', myAccountName);
//       prefs.setString('icon', myIcon);
//       prefs.setStringList('myNeedList', myNeedList);
//       prefs.setStringList('myMostWantedList', myMostWantedList);
//       prefs.setString('language', myLanguage);
//       prefs.setBool('theme', myClassicTheme);

//       database.reference().child(myID).update({'account_name': myAccountName});

//       database.reference().child(myID).once().then((DataSnapshot snapshot) {
//         if (snapshot.value['myFriends'] != null)
//           myFriends = snapshot.value['myFriends'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
//         else
//           myFriends = List<String>();
//       });
//     });
//     print("profile loaded.");
//   }

  void handleSearchEvent() {
    setState(() {
      if (this.searchIcon.icon == Icons.search) {
        this.searchIcon = Icon(
          Icons.close,
          color: iconColor,
        );
        this.appBarTitle = TextField(
          autofocus: true,
          controller: this.textEditController,
          style: new TextStyle(color: iconColor),
          cursorColor: searchCursorColor,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: searchCursorColor),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: iconColor,
            ),
            hintText: languageFile['PAGE_HOME']['SEARCH'],
            hintStyle: TextStyle(color: searchCursorColor),
          ),
          onChanged: searchEvent,
        );
        handleSearchStart();
      } else {
        searchResult.clear();
        handleSearchEnd();
      }
    });
  }

  void searchEvent(String searchText) {
    searchResult.clear();
    Map reversed = this.pokemonNamesDict.map((key, value) => MapEntry(value, key));

    if (isSearching != null) {
      for (int i = 0; i < this.pokemonNamesDictKeys.length; i++) {
        String pokemon = this.pokemonNamesDict[this.pokemonNamesDictKeys[i]];
        if (pokemon.toLowerCase().contains(searchText.toLowerCase())) {
          String key = reversed[pokemon];
          searchResult.add(key);
        }
      }
      for (int i = 0; i < this.pokemonNamesDictValues.length; i++) {
        String nr = reversed[this.pokemonNamesDictValues[i]];
        if (nr.contains(searchText.toLowerCase())) {
          searchResult.add(nr);
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
        "Tradedex",
        style: new TextStyle(
          color: iconColor,
        ),
      );
      isSearching = false;
      textEditController.clear();
    });
  }

  void selectedGen(String choice) {
    int counter = 0;
    searchResult.clear();

    setState(() {
      if (choice == 'Gen I') {
        while (this.pokemonNamesDictKeys[counter] != '152') {
          searchResult.add(this.pokemonNamesDictKeys[counter]);
          counter++;
        }
      } else if (choice == 'Gen II') {
        while (this.pokemonNamesDictKeys[counter] != '152') {
          counter++;
        }
        while (this.pokemonNamesDictKeys[counter] != '252') {
          searchResult.add(this.pokemonNamesDictKeys[counter]);
          counter++;
        }
      } else if (choice == 'Gen III') {
        while (this.pokemonNamesDictKeys[counter] != '252') {
          counter++;
        }
        while (this.pokemonNamesDictKeys[counter] != '387') {
          searchResult.add(this.pokemonNamesDictKeys[counter]);
          counter++;
        }
      } else if (choice == 'Gen IV') {
        while (this.pokemonNamesDictKeys[counter] != '387') {
          counter++;
        }
        while (this.pokemonNamesDictKeys[counter] != '495') {
          searchResult.add(this.pokemonNamesDictKeys[counter]);
          counter++;
        }
      } else if (choice == 'Gen V+') {
        while (this.pokemonNamesDictKeys[counter] != '495') {
          counter++;
        }
        while (counter < this.pokemonNamesDictKeys.length) {
          searchResult.add(this.pokemonNamesDictKeys[counter]);
          counter++;
        }
      }
    });
  }

  Widget buildPokemonMainPage() {
    return Container(
      color: backgroundColor,
      child: FutureBuilder(
        future: loadPokemonNames(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              color: backgroundColor,
            );
          } else {
            return Column(
              children: <Widget>[
                Flexible(
                  child: searchResult.length != 0 || textEditController.text.isNotEmpty
                      ? ListView.builder(
                          itemCount: searchResult.length,
                          itemBuilder: (context, i) {
                            return buildRowPokemon(searchResult[i]);
                          },
                        )
                      : ListView.builder(
                          itemCount: pokemonNamesDictKeys.length,
                          itemBuilder: (context, i) {
                            String idx = pokemonNamesDictKeys[i];
                            return buildRowPokemon(idx);
                          },
                        ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget buildRowPokemon(String idx) {
    String currPokemon = pokemonNamesDict[idx];
    String currPokemonNr = idx;
    bool secondaryPokemon = checkSecondaryPokemon(idx);
    bool primaryPokemon = checkPrimaryPokemon(idx);
    if (idx.contains('alolan')) currPokemonNr = idx.split('_')[0];

    return Container(
      child: ListTile(
        leading: getPokemonImage(idx),
        title: Text(
          "#" + currPokemonNr + ' ' + currPokemon,
          style: TextStyle(color: textColor),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(
                primaryPokemon ? Icons.favorite : Icons.favorite_border,
                color: primaryPokemon ? primaryListColor : primaryListColorOff,
              ),
              onPressed: () {
                setState(() {
                  primaryPokemon ? myProfile.primaryList.remove(idx) : myProfile.primaryList.add(idx);
                });
                savePokemonListsFirebase(myProfile);
                // saveMyMostWantedList();
              },
            ),
            IconButton(
              icon: Icon(secondaryPokemon ? MdiIcons.hexagon : MdiIcons.hexagonOutline, color: secondaryPokemon ? secondaryListColor : secondaryListColorOff),
              onPressed: () {
                setState(() {
                  secondaryPokemon ? myProfile.secondaryList.remove(idx) : myProfile.secondaryList.add(idx);
                });
                savePokemonListsFirebase(myProfile);
                // saveMyNeedList();
              },
            )
          ],
        ),
      ),
    );
  }

  bool checkSecondaryPokemon(String idx) {
    if (this.myProfile.secondaryList.contains(idx))
      return true;
    else
      return false;
  }

  bool checkPrimaryPokemon(String idx) {
    if (this.myProfile.primaryList.contains(idx))
      return true;
    else
      return false;
  }

  Widget buildDrawer(context) {
    return SafeArea(
      key: this.drawerKey,
      child: Drawer(
        child: Container(
          color: backgroundColor,
          child: ListView(
            children: <Widget>[
              Container(
                color: backgroundColor,
                child: DrawerHeader(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: backgroundColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: new BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.scaleDown,
                                    image: this.myProfile.icon.contains('alolan')
                                        ? AssetImage('assets_bundle/pokemon_icons_alolan/${this.myProfile.icon}.png')
                                        : AssetImage('assets_bundle/pokemon_icons_blank/${this.myProfile.icon}.png')),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  this.myProfile.accountName,
                                  style: TextStyle(color: textColor, fontSize: 20),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                getUserVerification(this.isSignedIn, this.myProfile.id),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: FlatButton(
                          child: Chip(
                            backgroundColor: buttonColor,
                            label: Text(
                              languageFile['PAGE_DRAWER']['COPY_TRADING_CODE'],
                              style: TextStyle(color: buttonTextColor),
                            ),
                          ),
                          onPressed: () => copyToClipboard(this.scaffoldKey, this.myProfile.id),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: signInButtonColor,
                child: ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    color: drawerIconColor,
                  ),
                  title: Text(
                    languageFile['PAGE_DRAWER']['SIGN_IN'],
                    style: TextStyle(color: textColor),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage(this.myProfile)),
                    );
                  },
                ),
              ),
              Container(
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: drawerIconColor,
                  ),
                  title: Text(
                    languageFile['PAGE_DRAWER']['HOME'],
                    style: TextStyle(color: textColor),
                  ),
                  onTap: Navigator.of(context).pop,
                ),
              ),
              Container(
                child: ListTile(
                  leading: Icon(
                    Icons.favorite,
                    color: drawerIconColor,
                  ),
                  title: Text(
                    languageFile['PAGE_DRAWER']['PRIMARY_LIST'],
                    style: TextStyle(color: textColor),
                  ),
                  onTap: () => goToPrimaryListSubpage(context),
                ),
              ),
              Container(
                child: ListTile(
                  leading: Icon(
                    MdiIcons.hexagon,
                    color: drawerIconColor,
                  ),
                  title: Text(
                    languageFile['PAGE_DRAWER']['SECONDARY_LIST'],
                    style: TextStyle(color: textColor),
                  ),
                  onTap: () => goToSecondaryListSubpage(context),
                ),
              ),
              Container(
                child: ListTile(
                  leading: Icon(
                    MdiIcons.pokeball,
                    color: drawerIconColor,
                  ),
                  title: Text(
                    languageFile['PAGE_DRAWER']['OFFICIAL_COLLECTION'],
                    style: TextStyle(color: textColor),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OfficialCollectionPage(this.pokemonNamesDict, this.pokemonNamesBlankDictKeys, this.myProfile)),
                    );
                  },
                ),
              ),
              Container(
                child: ListTile(
                  leading: Icon(
                    MdiIcons.bookOpen,
                    color: drawerIconColor,
                  ),
                  title: Text(
                    languageFile['PAGE_DRAWER']['INDIVIDUAL_COLLECTION'],
                    style: TextStyle(color: textColor),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IndividualCollectionPage(this.myProfile)),
                    );
                  },
                ),
              ),
              Container(
                child: ListTile(
                  leading: Icon(
                    Icons.people,
                    color: drawerIconColor,
                  ),
                  title: Text(
                    languageFile['PAGE_DRAWER']['CONTACTS'],
                    style: TextStyle(color: textColor),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactsPage(this.pokemonNamesDict, this.myProfile)),
                    );
                  },
                ),
              ),
              Container(
                child: ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: drawerIconColor,
                  ),
                  title: Text(
                    languageFile['PAGE_DRAWER']['SETTINGS'],
                    style: TextStyle(color: textColor),
                  ),
                  onTap: () {
                    final result = Navigator.of(context).push(
                      MaterialPageRoute<bool>(
                        builder: (context) => SettingsPage(this.myProfile, this.pokemonNamesDictKeys),
                      ),
                    );
                    result.then((darkTheme) {
                      setState(() {
                        setColorTheme(darkTheme);
                      });
                    });
                  },
                ),
              ),
              Container(
                child: ListTile(
                  leading: Icon(
                    Icons.info_outline,
                    color: drawerIconColor,
                  ),
                  title: Text(
                    languageFile['PAGE_DRAWER']['ABOUT'],
                    style: TextStyle(color: textColor),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
