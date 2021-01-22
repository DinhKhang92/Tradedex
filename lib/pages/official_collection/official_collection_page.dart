import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tradedex/Global/Components/copyToClipboard.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/Global/Components/loadDataFirebase.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:tradedex/pages/official_collection/pages/lucky/lucky_page.dart';
import 'package:tradedex/pages/official_collection/pages/shiny/shiny_page.dart';

import 'dart:convert';

import 'cubit/official_cubit.dart';

class OfficialCollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OfficialCollectionPageState();
}

class OfficialCollectionPageState extends State<OfficialCollectionPage> {
  // int navIndex;
  // Widget appBarTitle;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // // general
  // Map pokemonNamesDict;
  // List<String> pokemonNamesBlankDictKeys;
  // Map pokemonNamesDictCopy;

  // Icon searchIcon;

  // TextEditingController textEditController;
  // List<String> searchResult;
  // bool isSearching;
  // String searchText;

  // // collections
  // OfficialCollection myOfficialCollection;

  // // gender
  // List<dynamic> pokemonGenderDict;

  // // profile
  // Profile myProfile;

  // OfficialCollectionPageState() {
  //   this.navIndex = 0;
  //   this.appBarTitle = Text("Luckydex");
  //   this.scaffoldKey = new GlobalKey<ScaffoldState>();

  //   this.pokemonNamesDict = pokemonNamesDict;
  //   this.pokemonNamesBlankDictKeys = pokemonNamesBlankDictKeys;
  //   this.pokemonNamesDictCopy = new Map.from(pokemonNamesDict);

  //   this.searchIcon = Icon(Icons.search);
  //   this.textEditController = new TextEditingController();
  //   this.searchResult = List<String>();
  //   this.isSearching = false;

  //   // debug
  //   this.myOfficialCollection = new OfficialCollection();

  //   // profile
  //   this.myProfile = myProfile;

  //   getCopyOfDict();

  //   // loading files
  //   loadGenderJson();

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

  // void loadGenderJson() async {
  //   await rootBundle
  //       .loadString('json/official_collections/gender.json')
  //       .then((genderDict) {
  //     this.pokemonGenderDict = jsonDecode(genderDict);
  //   });
  // }

  // @override
  // void initState() {
  //   loadOfficialCollectionFirebase(this.myProfile).then((officialCollection) {
  //     setState(() {
  //       this.myOfficialCollection = officialCollection;
  //     });
  //   });
  //   super.initState();
  // }

  // void _loadCollectionList() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   luckyList = prefs.getStringList('luckylist') ?? [];
  //   shinyList = prefs.getStringList('shinylist') ?? [];
  // }

  // void _saveCollectionList() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('luckyList', luckyList);
  //   prefs.setStringList('shinyList', shinyList);
  //   prefs.setStringList('maleList', maleList);
  //   prefs.setStringList('femaleList', femaleList);
  //   prefs.setStringList('neutralList', neutralList);
  // }

  // void showAllPokemon() {
  //   if (this.navIndex == 0) {
  //     this.myOfficialCollection.luckyList =
  //         new List<String>.from(this.pokemonNamesBlankDictKeys);
  //   } else if (this.navIndex == 1) {
  //     this.myOfficialCollection.shinyList =
  //         new List<String>.from(this.pokemonNamesBlankDictKeys);
  //   } else {
  //     List<String> currGender;
  //     for (int i = 0; i < this.pokemonGenderDict.length; i++) {
  //       currGender = this.pokemonGenderDict[i]['gender'].keys.toList();
  //       if (currGender.length == 2) {
  //         this
  //             .myOfficialCollection
  //             .maleList
  //             .add(this.pokemonGenderDict[i]['id'].toString().padLeft(3, '0'));
  //         this
  //             .myOfficialCollection
  //             .femaleList
  //             .add(this.pokemonGenderDict[i]['id'].toString().padLeft(3, '0'));
  //       } else {
  //         if (currGender[0] == 'malePercent')
  //           this.myOfficialCollection.maleList.add(
  //               this.pokemonGenderDict[i]['id'].toString().padLeft(3, '0'));
  //         else if (currGender[0] == 'femalePercent')
  //           this.myOfficialCollection.femaleList.add(
  //               this.pokemonGenderDict[i]['id'].toString().padLeft(3, '0'));
  //         else
  //           this.myOfficialCollection.neutralList.add(
  //               this.pokemonGenderDict[i]['id'].toString().padLeft(3, '0'));
  //       }
  //     }
  //   }
  // }

  // void deleteList() {
  //   if (this.navIndex == 0) {
  //     this.myOfficialCollection.luckyList.clear();
  //   } else if (this.navIndex == 1) {
  //     this.myOfficialCollection.shinyList.clear();
  //   } else {
  //     this.myOfficialCollection.maleList.clear();
  //     this.myOfficialCollection.femaleList.clear();
  //     this.myOfficialCollection.neutralList.clear();
  //   }
  // }

  @override
  void initState() {
    this._loadPokemon();
    super.initState();
  }

  void _loadPokemon() {
    BlocProvider.of<OfficialCubit>(context).loadPokemon(context);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> officialPages = [
      // luckySubPage(),
      // Text("0"),
      LuckyPage(),
      ShinyPage(),
      Text("2"),
      // shinySubpage(),
      // genderSubpage(),
    ];

    return DefaultTabController(
      length: officialPages.length,
      child: SafeArea(
        child: BlocBuilder<OfficialCubit, OfficialState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: backgroundColor,
              key: this._scaffoldKey,
              appBar: AppBar(
                title: Text("Luckydex"),
                backgroundColor: appBarColor,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    color: iconColor,
                    onPressed: () {},
                    // onPressed: () => handleSearchEvent(),
                  ),
                  IconButton(
                    icon: Icon(
                      MdiIcons.eyeOff,
                      color: iconColor,
                    ),
                    onPressed: () {
                      // setState(() {
                      //   deleteList();
                      // });
                      // saveOfficialCollectionFirebase(
                      //     this.myOfficialCollection, this.myProfile);
                      // _saveCollectionList();
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: iconColor,
                    ),
                    onPressed: () {
                      // setState(() {
                      //   showAllPokemon();
                      // });
                      // saveOfficialCollectionFirebase(
                      //     this.myOfficialCollection, this.myProfile);
                      // _saveCollectionList();
                    },
                  ),
                  // (navIndex < 2)
                  //     ? IconButton(
                  //         icon: Icon(
                  //           Icons.content_copy,
                  //           color: iconColor,
                  //         ),
                  //         onPressed: () {
                  //           String copyToClipboardString;
                  //           this.navIndex == 0
                  //               ? copyToClipboardString = getCopyListString(
                  //                   this.myOfficialCollection.luckyList)
                  //               : copyToClipboardString = getCopyListString(
                  //                   this.myOfficialCollection.shinyList);
                  //           copyToClipboard(this.scaffoldKey, copyToClipboardString);
                  //         },
                  //       )
                  //     : Text(''),
                ],
              ),
              body: officialPages[state.navIdx],
              bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: backgroundColor,
                  primaryColor: buttonColor,
                  textTheme: Theme.of(context)
                      .textTheme
                      .copyWith(caption: TextStyle(color: subTextColor)),
                ),
                child: BottomNavigationBar(
                  currentIndex: state.navIdx,
                  onTap: (index) =>
                      BlocProvider.of<OfficialCubit>(context).setNavIdx(index),
                  // print(index);
                  // setState(() {
                  //   this.navIndex = index;
                  //   this.searchResult.clear();
                  //   handleSearchEnd();
                  //   setAppBarTitle();
                  // });
                  // },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(MdiIcons.star),
                      label: AppLocalizations.of(context)
                          .translate('PAGE_OFFICIAL_COLLECTION.LUCKYDEX.TITLE'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(MdiIcons.flare),
                      label: AppLocalizations.of(context)
                          .translate('PAGE_OFFICIAL_COLLECTION.SHINYDEX.TITLE'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(MdiIcons.genderMaleFemale),
                      label: AppLocalizations.of(context).translate(
                          'PAGE_OFFICIAL_COLLECTION.GENDERDEX.TITLE'),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // void handleSearchEvent() {
  //   setState(() {
  //     if (this.searchIcon.icon == Icons.search) {
  //       this.searchIcon = Icon(
  //         Icons.close,
  //         color: iconColor,
  //       );
  //       this.appBarTitle = TextField(
  //         autofocus: true,
  //         controller: this.textEditController,
  //         style: new TextStyle(color: iconColor),
  //         cursorColor: searchCursorColor,
  //         decoration: InputDecoration(
  //           focusedBorder: UnderlineInputBorder(
  //             borderSide: BorderSide(color: searchCursorColor),
  //           ),
  //           prefixIcon: Icon(
  //             Icons.search,
  //             color: iconColor,
  //           ),
  //           hintText: languageFile['PAGE_HOME']['SEARCH'],
  //           hintStyle: TextStyle(color: searchCursorColor),
  //         ),
  //         onChanged: searchEvent,
  //       );
  //       handleSearchStart();
  //     } else {
  //       searchResult.clear();
  //       handleSearchEnd();
  //     }
  //   });
  // }

  // void getCopyOfDict() {
  //   this.pokemonNamesDict.forEach((key, value) {
  //     if (key.contains('alolan')) {
  //       this.pokemonNamesDictCopy.remove(key);
  //     }
  //   });
  // }

  // void searchEvent(String searchText) {
  //   searchResult.clear();
  //   Map reversed =
  //       this.pokemonNamesDictCopy.map((key, value) => MapEntry(value, key));

  //   if (isSearching != null) {
  //     for (int i = 0; i < this.pokemonNamesDictCopy.keys.toList().length; i++) {
  //       String pokemon = this
  //           .pokemonNamesDictCopy[this.pokemonNamesDictCopy.keys.toList()[i]];
  //       if (pokemon.toLowerCase().contains(searchText.toLowerCase())) {
  //         String key = reversed[pokemon];
  //         searchResult.add(key);
  //       }
  //     }
  //     for (int i = 0;
  //         i < this.pokemonNamesDictCopy.values.toList().length;
  //         i++) {
  //       String nr = reversed[this.pokemonNamesDictCopy.values.toList()[i]];
  //       if (nr.contains(searchText.toLowerCase())) {
  //         searchResult.add(nr);
  //       }
  //     }
  //   }
  // }

  // void handleSearchStart() {
  //   setState(() {
  //     isSearching = true;
  //   });
  // }

  // void handleSearchEnd() {
  //   setState(() {
  //     this.searchIcon = new Icon(
  //       Icons.search,
  //       color: iconColor,
  //     );
  //     setAppBarTitle();
  //     isSearching = false;
  //     textEditController.clear();
  //   });
  // }

  // void setAppBarTitle() {
  //   if (this.navIndex == 0)
  //     this.appBarTitle = Text('Luckydex');
  //   else if (this.navIndex == 1)
  //     this.appBarTitle = Text('Shinydex');
  //   else if (this.navIndex == 2) this.appBarTitle = Text("Genderdex");
  // }

  // Widget genderSubpage() {
  //   return Container(
  //     color: backgroundColor,
  //     child: this.searchResult.length != 0 ||
  //             this.textEditController.text.isNotEmpty
  //         ? GridView.builder(
  //             padding: EdgeInsets.fromLTRB(20, 10, 5, 0),
  //             itemCount: this.searchResult.length,
  //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: 6,
  //               mainAxisSpacing: 15.0,
  //             ),
  //             itemBuilder: (context, i) {
  //               String idx = this.searchResult[i];
  //               bool needPokemon = checkNeedPokemon(
  //                   idx, this.myOfficialCollection.neutralList, i);
  //               return GridTile(
  //                 child: showGender(idx, needPokemon),
  //                 footer: getGender(i, idx),
  //               );
  //             },
  //           )
  //         : GridView.builder(
  //             padding: EdgeInsets.fromLTRB(20, 10, 5, 0),
  //             itemCount: this.pokemonNamesBlankDictKeys.length,
  //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: 6,
  //               mainAxisSpacing: 15.0,
  //             ),
  //             itemBuilder: (context, i) {
  //               String idx = this.pokemonNamesBlankDictKeys[i];
  //               bool needPokemon = checkNeedPokemon(
  //                   idx, this.myOfficialCollection.neutralList, i);
  //               return GridTile(
  //                 child: showGender(idx, needPokemon),
  //                 footer: getGender(i, idx),
  //               );
  //             },
  //           ),
  //   );
  // }

  // Widget showGender(String idx, bool pokemonNeeded) {
  //   return Stack(
  //     children: <Widget>[
  //       Image(
  //         color: pokemonNeeded ? silhouetteColor : null,
  //         image: AssetImage('assets_bundle/pokemon_icons_blank/$idx.png'),
  //         height: 45.0,
  //         width: 45.0,
  //         fit: BoxFit.cover,
  //       ),
  //     ],
  //   );
  // }

  // bool checkNeedPokemon(String idx, List<String> pokemonList, int i) {
  //   bool needPokemon = true;
  //   pokemonList.contains(idx) ? needPokemon = false : needPokemon = true;
  //   if (this.navIndex < 2) return needPokemon;

  //   List<String> genderList = this.pokemonGenderDict[i]['gender'].keys.toList();
  //   if (genderList.length == 2)
  //     this.myOfficialCollection.femaleList.contains(idx) &&
  //             this.myOfficialCollection.maleList.contains(idx)
  //         ? needPokemon = false
  //         : needPokemon = true;
  //   else
  //     this.myOfficialCollection.femaleList.contains(idx) ||
  //             this.myOfficialCollection.maleList.contains(idx) ||
  //             this.myOfficialCollection.neutralList.contains(idx)
  //         ? needPokemon = false
  //         : needPokemon = true;
  //   return needPokemon;
  // }

  // String getCopyListString(List<String> pokemonList) {
  //   String myCopyString = '';
  //   List<int> tmpList = List<int>();
  //   for (int i = 0; i < pokemonList.length; i++) {
  //     tmpList.add(int.parse(pokemonList[i]));
  //   }

  //   tmpList.sort();
  //   myCopyString = tmpList.join(',');

  //   return myCopyString;
  // }

  // Widget getGender(int i, String idx) {
  //   List<String> currGender = this.pokemonGenderDict[i]['gender'].keys.toList();
  //   if (currGender.length == 2) {
  //     return Row(
  //       children: <Widget>[
  //         InkResponse(
  //           child: Icon(
  //             MdiIcons.genderMale,
  //             color: showMale(idx),
  //           ),
  //           onTap: () {
  //             setState(() {
  //               this.myOfficialCollection.maleList.contains(idx)
  //                   ? this.myOfficialCollection.maleList.remove(idx)
  //                   : this.myOfficialCollection.maleList.add(idx);
  //             });
  //             saveOfficialCollectionFirebase(
  //                 this.myOfficialCollection, this.myProfile);
  //             // _saveMaleList();
  //           },
  //         ),
  //         InkResponse(
  //           child: Icon(
  //             MdiIcons.genderFemale,
  //             color: showFemale(idx),
  //           ),
  //           onTap: () {
  //             setState(() {
  //               this.myOfficialCollection.femaleList.contains(idx)
  //                   ? this.myOfficialCollection.femaleList.remove(idx)
  //                   : this.myOfficialCollection.femaleList.add(idx);
  //             });
  //             saveOfficialCollectionFirebase(
  //                 this.myOfficialCollection, this.myProfile);
  //             // _saveFemaleList();
  //           },
  //         ),
  //       ],
  //     );
  //   } else {
  //     if (currGender[0] == 'malePercent') {
  //       return Row(
  //         children: <Widget>[
  //           InkResponse(
  //             child: Icon(
  //               MdiIcons.genderMale,
  //               color: showMale(idx),
  //             ),
  //             onTap: () {
  //               setState(() {
  //                 this.myOfficialCollection.maleList.contains(idx)
  //                     ? this.myOfficialCollection.maleList.remove(idx)
  //                     : this.myOfficialCollection.maleList.add(idx);
  //               });
  //               saveOfficialCollectionFirebase(
  //                   this.myOfficialCollection, this.myProfile);
  //               // _saveMaleList();
  //             },
  //           )
  //         ],
  //       );
  //     } else if (currGender[0] == 'femalePercent') {
  //       return InkResponse(
  //         child: Icon(
  //           MdiIcons.genderFemale,
  //           color: showFemale(idx),
  //         ),
  //         onTap: () {
  //           setState(() {
  //             this.myOfficialCollection.femaleList.contains(idx)
  //                 ? this.myOfficialCollection.femaleList.remove(idx)
  //                 : this.myOfficialCollection.femaleList.add(idx);
  //           });
  //           saveOfficialCollectionFirebase(
  //               this.myOfficialCollection, this.myProfile);
  //           // _saveFemaleList();
  //         },
  //       );
  //     } else if (currGender[0] == 'genderlessPercent') {
  //       return Row(
  //         children: <Widget>[
  //           InkResponse(
  //             child: Icon(
  //               Icons.radio_button_unchecked,
  //               color: showNeutral(idx),
  //             ),
  //             onTap: () {
  //               setState(() {
  //                 this.myOfficialCollection.neutralList.contains(idx)
  //                     ? this.myOfficialCollection.neutralList.remove(idx)
  //                     : this.myOfficialCollection.neutralList.add(idx);
  //               });
  //               saveOfficialCollectionFirebase(
  //                   this.myOfficialCollection, this.myProfile);
  //               // _saveNeutralList();
  //             },
  //           )
  //         ],
  //       );
  //     } else {
  //       return Text('');
  //     }
  //   }
  // }

  // Color showMale(String idx) {
  //   if (this.myOfficialCollection.maleList.contains(idx))
  //     return genderMaleColor;
  //   else
  //     return silhouetteColor;
  // }

  // Color showFemale(String idx) {
  //   if (this.myOfficialCollection.femaleList.contains(idx))
  //     return genderFemaleColor;
  //   else
  //     return silhouetteColor;
  // }

  // Color showNeutral(String idx) {
  //   if (this.myOfficialCollection.neutralList.contains(idx))
  //     return genderNeutralColor;
  //   else
  //     return silhouetteColor;
  // }
}

// class CollectionDexBody extends StatefulWidget {
//   final Map pokemonNamesDict;
//   final List<String> pokemonNamesBlankDictKeys;
//   final int navIndex;

//   CollectionDexBody(this.pokemonNamesDict, this.pokemonNamesBlankDictKeys, this.navIndex);

//   @override
//   State<StatefulWidget> createState() {
//     return CollectionDexBodyState(this.pokemonNamesDict, this.pokemonNamesBlankDictKeys, this.navIndex);
//   }
// }

// class CollectionDexBodyState extends State<CollectionDexBody> {
//   Map pokemonNamesDict;
//   List<String> pokemonNamesBlankDictKeys;
//   int navIndex;

//   CollectionDexBodyState(pokemonNamesDict, pokemonNamesBlankDictKeys, navIndex) {
//     this.pokemonNamesDict = pokemonNamesDict;
//     this.pokemonNamesBlankDictKeys = pokemonNamesBlankDictKeys;
//     this.navIndex = navIndex;
//   }

//   void initState() {
//     super.initState();
//     // _loadCollectionList();
//     // _loadGenderList();
//   }

//   // Future<List<String>> _loadCurrPage() async {
//   //   return [];
//   // }

//   // void _loadGenderList() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   maleList = prefs.getStringList('maleList') ?? [];
//   //   femaleList = prefs.getStringList('femaleList') ?? [];
//   //   neutralList = prefs.getStringList('neutralList') ?? [];
//   // }

//   // void _loadCollectionList() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   luckyList = prefs.getStringList('luckyList') ?? [];
//   //   shinyList = prefs.getStringList('shinyList') ?? [];
//   // }

//   // void _saveShinyList() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   prefs.setStringList('shinyList', shinyList);
//   // }

//   // void _saveLuckyList() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   prefs.setStringList('luckyList', luckyList);
//   // }

//   // void _saveMaleList() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   prefs.setStringList('maleList', maleList);
//   // }

//   // void _saveFemaleList() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   prefs.setStringList('femaleList', femaleList);
//   // }

//   // void _saveNeutralList() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   prefs.setStringList('neutralList', neutralList);
//   // }
