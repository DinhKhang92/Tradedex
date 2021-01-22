import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/pages/about/about_page.dart';
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

import 'package:tradedex/pages/home/Subpages/PrimaryListSubpage.dart';
import 'package:tradedex/pages/home/Subpages/SecondaryListSubpage.dart';
import 'package:tradedex/Settings/SettingsPage.dart';
import 'package:tradedex/Global/Components/copyToClipboard.dart';
import 'package:tradedex/SignIn/SignInPage.dart';
import 'package:tradedex/OfficialCollection/OfficialCollectionPage.dart';
import 'package:tradedex/IndividualCollection/IndividualCollectionPage.dart';
import 'package:tradedex/pages/home/cubit/pokemon_cubit.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:tradedex/components/pokemon_image.dart';
import 'package:tradedex/components/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    this._loadPokemon();
    super.initState();
  }

  void _loadPokemon() {
    BlocProvider.of<PokemonCubit>(context).loadPokemon(context);
  }

  // function variables
  // FirebaseDatabase database;
  // String searchText;
  // bool isSearching;
  // List<String> searchResult;
  // bool isSignedIn;
  // TextEditingController textEditController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // GlobalKey<DrawerControllerState> drawerKey;

  // // profile
  // Profile myProfile;

  // // widgets
  // Widget appBarTitle;
  // Icon searchIcon;

  // // pokemon data
  // Map pokemonNamesDict;
  // List<dynamic> pokemonNamesDictKeys;
  // List<dynamic> pokemonNamesDictValues;
  // List<dynamic> pokemonNamesBlankDictKeys;

  // HomePageState() {
  //   // profile
  //   // this.myProfile = myProfile;

  //   // function variables
  //   this.isSearching = false;
  //   this.isSignedIn = false;
  //   this.searchResult = List<String>();
  //   this.textEditController = new TextEditingController();
  //   this.scaffoldKey = new GlobalKey<ScaffoldState>();
  //   this.drawerKey = new GlobalKey<DrawerControllerState>();
  //   this.database = FirebaseDatabase.instance;

  //   // widgets
  //   this.searchIcon = Icon(Icons.search);
  //   this.appBarTitle = Text("Tradedex");

  //   // pokemon data
  //   this.pokemonNamesDict = new Map();
  //   this.pokemonNamesDictKeys = new List<dynamic>();
  //   this.pokemonNamesDictValues = new List<dynamic>();
  //   this.pokemonNamesBlankDictKeys = new List<dynamic>();

  //   // searching function
  //   textEditController.addListener(() {
  //     if (textEditController.text.isEmpty) {
  //       setState(() {
  //         isSearching = false;
  //         searchText = "";
  //       });
  //     } else {
  //       setState(() {
  //         isSearching = true;
  //         searchText = textEditController.text;
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        key: this._scaffoldKey,
        appBar: AppBar(
          title: _buildAppBarTitle(),
          backgroundColor: appBarColor,
          leading: IconButton(
            icon: Icon(Icons.menu),
            color: iconColor,
            onPressed: () => this._scaffoldKey.currentState.openDrawer(),
          ),
          actions: <Widget>[
            IconButton(
              icon: _buildSearchbar(),
              color: iconColor,
              onPressed: () => {},
            ),
            IconButton(
              icon: Icon(Icons.favorite),
              color: iconColor,
              onPressed: () => Navigator.of(context).pushNamed('/primary'),
            ),
            // PopupMenuButton<String>(
            //   onSelected: selectedGen,
            //   itemBuilder: (BuildContext context) {
            //     return getGens().map((String choice) {
            //       return PopupMenuItem<String>(
            //         value: choice,
            //         child: Text(choice),
            //       );
            //     }).toList();
            //   },
            // ),
          ],
        ),
        drawer: DrawerComponent(),
        body: _buildContent(),
      ),
    );
  }

  Widget _buildSearchbar() {
    return Icon(Icons.search);
  }

  Widget _buildAppBarTitle() {
    return Text("Tradedex");
  }

//   List<String> getGens() {
//     List<String> genList = new List<String>();
//     languageFile['PAGE_HOME']['GENS'].forEach((key, value) => genList.add(value));
//     return genList;
//   }

//   void initState() {
//     super.initState();
//     // loadMyProfile();
//     // loadIndividualCollection();
//     // getIndividualCollectionFileNames();
//     getUser();
//   }

//   void getUser() async {
//     return await FirebaseAuth.instance.currentUser().then((user) {
//       setState(() {
//         user != null ? this.isSignedIn = true : this.isSignedIn = false;
//       });
//     });
//   }

// //   void loadMyProfile() async {
// //     print("load Profile ...");
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     PackageInfo packageInfo = await PackageInfo.fromPlatform();
// //     setState(() {
// //       myID = prefs.getString('myID') ?? database.reference().push().key;
// //       myAccountName = prefs.getString('myAccountName') ?? 'Trainer xy';
// //       myIcon = prefs.getString('icon') ?? '132';
// //       myNeedList = prefs.getStringList('myNeedList') ?? [];
// //       myMostWantedList = prefs.getStringList('myMostWantedList') ?? [];
// //       myLanguage = prefs.getString('language') ?? 'en';
// //       myClassicTheme = prefs.getBool('theme') ?? false;
// //       myVersion = packageInfo.version;

// //       if (myClassicTheme) {
// //         redColor = Colors.grey[800];
// //         listTileColor = Colors.black87;
// //         textColor = Colors.white;
// //         markBorderColor = Colors.white70;
// //         markPokemonColor = Colors.red[900];
// //         subTextColor = Colors.white54;
// //         captionTextColor = Colors.white54;
// //         dividerColor = Colors.grey[600];
// //         buttonColor = Colors.grey[600];
// //         iconColor = Colors.white;
// //         drawerColor = Colors.black87;
// //         backgroundColor = Colors.black87;
// //         bottomNavBarColor = Colors.grey[800];
// //         bottomNavBarIconColor = Colors.white;
// //       } else {
// //         redColor = Colors.red[900];
// //         listTileColor = Colors.white;
// //         textColor = Colors.black;
// //         markBorderColor = null;
// //         markPokemonColor = Colors.red;
// //         subTextColor = Colors.grey[700];
// //         captionTextColor = Colors.grey[600];
// //         dividerColor = Colors.grey[500];
// //         buttonColor = Colors.red[200];
// //         iconColor = Colors.grey[600];
// //         drawerColor = Colors.grey[100];
// //         backgroundColor = Colors.white;
// //         bottomNavBarColor = Colors.grey[100];
// //         bottomNavBarIconColor = Colors.red[900];
// //       }

// //       prefs.setString('myID', myID);
// //       prefs.setString('myAccountName', myAccountName);
// //       prefs.setString('icon', myIcon);
// //       prefs.setStringList('myNeedList', myNeedList);
// //       prefs.setStringList('myMostWantedList', myMostWantedList);
// //       prefs.setString('language', myLanguage);
// //       prefs.setBool('theme', myClassicTheme);

// //       database.reference().child(myID).update({'account_name': myAccountName});

// //       database.reference().child(myID).once().then((DataSnapshot snapshot) {
// //         if (snapshot.value['myFriends'] != null)
// //           myFriends = snapshot.value['myFriends'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
// //         else
// //           myFriends = List<String>();
// //       });
// //     });
// //     print("profile loaded.");
// //   }

//   void handleSearchEvent() {
//     setState(() {
//       if (this.searchIcon.icon == Icons.search) {
//         this.searchIcon = Icon(
//           Icons.close,
//           color: iconColor,
//         );
//         this.appBarTitle = TextField(
//           autofocus: true,
//           controller: this.textEditController,
//           style: new TextStyle(color: iconColor),
//           cursorColor: searchCursorColor,
//           decoration: InputDecoration(
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: searchCursorColor),
//             ),
//             prefixIcon: Icon(
//               Icons.search,
//               color: iconColor,
//             ),
//             hintText: languageFile['PAGE_HOME']['SEARCH'],
//             hintStyle: TextStyle(color: searchCursorColor),
//           ),
//           onChanged: searchEvent,
//         );
//         handleSearchStart();
//       } else {
//         searchResult.clear();
//         handleSearchEnd();
//       }
//     });
//   }

//   void searchEvent(String searchText) {
//     searchResult.clear();
//     Map reversed = this.pokemonNamesDict.map((key, value) => MapEntry(value, key));

//     if (isSearching != null) {
//       for (int i = 0; i < this.pokemonNamesDictKeys.length; i++) {
//         String pokemon = this.pokemonNamesDict[this.pokemonNamesDictKeys[i]];
//         if (pokemon.toLowerCase().contains(searchText.toLowerCase())) {
//           String key = reversed[pokemon];
//           searchResult.add(key);
//         }
//       }
//       for (int i = 0; i < this.pokemonNamesDictValues.length; i++) {
//         String nr = reversed[this.pokemonNamesDictValues[i]];
//         if (nr.contains(searchText.toLowerCase())) {
//           searchResult.add(nr);
//         }
//       }
//     }
//   }

//   void handleSearchStart() {
//     setState(() {
//       isSearching = true;
//     });
//   }

//   void handleSearchEnd() {
//     setState(() {
//       this.searchIcon = new Icon(
//         Icons.search,
//         color: iconColor,
//       );
//       this.appBarTitle = new Text(
//         "Tradedex",
//         style: new TextStyle(
//           color: iconColor,
//         ),
//       );
//       isSearching = false;
//       textEditController.clear();
//     });
//   }

//   void selectedGen(String choice) {
//     int counter = 0;
//     searchResult.clear();

//     setState(() {
//       if (choice == 'Gen I') {
//         while (this.pokemonNamesDictKeys[counter] != '152') {
//           searchResult.add(this.pokemonNamesDictKeys[counter]);
//           counter++;
//         }
//       } else if (choice == 'Gen II') {
//         while (this.pokemonNamesDictKeys[counter] != '152') {
//           counter++;
//         }
//         while (this.pokemonNamesDictKeys[counter] != '252') {
//           searchResult.add(this.pokemonNamesDictKeys[counter]);
//           counter++;
//         }
//       } else if (choice == 'Gen III') {
//         while (this.pokemonNamesDictKeys[counter] != '252') {
//           counter++;
//         }
//         while (this.pokemonNamesDictKeys[counter] != '387') {
//           searchResult.add(this.pokemonNamesDictKeys[counter]);
//           counter++;
//         }
//       } else if (choice == 'Gen IV') {
//         while (this.pokemonNamesDictKeys[counter] != '387') {
//           counter++;
//         }
//         while (this.pokemonNamesDictKeys[counter] != '495') {
//           searchResult.add(this.pokemonNamesDictKeys[counter]);
//           counter++;
//         }
//       } else if (choice == 'Gen V+') {
//         while (this.pokemonNamesDictKeys[counter] != '495') {
//           counter++;
//         }
//         while (counter < this.pokemonNamesDictKeys.length) {
//           searchResult.add(this.pokemonNamesDictKeys[counter]);
//           counter++;
//         }
//       }
//     });
//   }

  Widget _buildContent() {
    return BlocBuilder<PokemonCubit, PokemonState>(
      builder: (context, state) {
        if (state is PokemonLoaded) {
          return _buildLoaded();
        }
        return Container(color: backgroundColor);
      },
    );
  }

  Widget _buildLoaded() {
    return BlocBuilder<PokemonCubit, PokemonState>(
      builder: (context, state) {
        if (state is PokemonLoaded)
          return Container(
            color: backgroundColor,
            child: ListView.builder(
              itemCount: state.pokemon.length,
              itemBuilder: (context, i) {
                String pokemonKey = state.pokemon.keys.toList()[i];
                return _buildRowElement(pokemonKey);
              },
            ),
          );
        return Container();
      },
    );
  }

  Widget _buildRowElement(String pokemonKey) {
    String pokemonName = AppLocalizations.of(context).translate('POKEMON.$pokemonKey');
    String number = pokemonKey.split('_').first;
    return Container(
      child: ListTile(
        leading: getPokemonImage(pokemonKey),
        title: Text(
          "#$number $pokemonName",
          style: TextStyle(color: textColor),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BlocBuilder<PokemonCubit, PokemonState>(
              builder: (context, state) {
                if (state is PokemonLoaded) {
                  return IconButton(
                    icon: Icon(
                      state.pokemon[pokemonKey]['primary'] ? Icons.favorite : Icons.favorite_border,
                      color: state.pokemon[pokemonKey]['primary'] ? primaryListColor : primaryListColorOff,
                    ),
                    onPressed: () => BlocProvider.of<PokemonCubit>(context).togglePrimary(pokemonKey),
                    // setState(() {
                    //   primaryPokemon ? myProfile.primaryList.remove(idx) : myProfile.primaryList.add(idx);
                    // });
                    // savePokemonListsFirebase(myProfile);
                    // // saveMyMostWantedList();
                  );
                }
                return Container();
              },
            ),
            BlocBuilder<PokemonCubit, PokemonState>(
              builder: (context, state) {
                if (state is PokemonLoaded) {
                  return IconButton(
                    icon: Icon(
                      state.pokemon[pokemonKey]['secondary'] ? MdiIcons.hexagon : MdiIcons.hexagonOutline,
                      color: state.pokemon[pokemonKey]['secondary'] ? secondaryListColor : secondaryListColorOff,
                    ),
                    onPressed: () => BlocProvider.of<PokemonCubit>(context).toggleSecondary(pokemonKey),
                    // setState(() {
                    //   secondaryPokemon ? myProfile.secondaryList.remove(idx) : myProfile.secondaryList.add(idx);
                    // });
                    // savePokemonListsFirebase(myProfile);
                    // // saveMyNeedList();
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
