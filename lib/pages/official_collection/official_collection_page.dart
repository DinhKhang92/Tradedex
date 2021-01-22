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
import 'package:tradedex/pages/official_collection/pages/gender/gender_page.dart';
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
    this._loadGender();
    super.initState();
  }

  void _loadPokemon() {
    BlocProvider.of<OfficialCubit>(context).loadPokemon(context);
  }

  void _loadGender() {
    BlocProvider.of<OfficialCubit>(context).loadGender(context);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> officialPages = [
      LuckyPage(),
      ShinyPage(),
      GenderPage(),
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
                title: _buildAppbarTitle(),
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
                  textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: subTextColor)),
                ),
                child: BottomNavigationBar(
                  currentIndex: state.navIdx,
                  onTap: (index) => BlocProvider.of<OfficialCubit>(context).setNavIdx(index),
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
                      label: AppLocalizations.of(context).translate('PAGE_OFFICIAL_COLLECTION.LUCKYDEX.TITLE'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(MdiIcons.flare),
                      label: AppLocalizations.of(context).translate('PAGE_OFFICIAL_COLLECTION.SHINYDEX.TITLE'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(MdiIcons.genderMaleFemale),
                      label: AppLocalizations.of(context).translate('PAGE_OFFICIAL_COLLECTION.GENDERDEX.TITLE'),
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

  Widget _buildAppbarTitle() {
    return BlocBuilder<OfficialCubit, OfficialState>(
      builder: (context, state) {
        if (state.navIdx == 0)
          return Text(AppLocalizations.of(context).translate('PAGE_OFFICIAL_COLLECTION.LUCKYDEX.TITLE'));
        else if (state.navIdx == 1)
          return Text(AppLocalizations.of(context).translate('PAGE_OFFICIAL_COLLECTION.SHINYDEX.TITLE'));
        else if (state.navIdx == 2)
          return Text(AppLocalizations.of(context).translate('PAGE_OFFICIAL_COLLECTION.GENDERDEX.TITLE'));
        else
          return Container();
      },
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

}
