import 'package:flutter/material.dart';
import 'package:tradedex/Global/Components/copyToClipboard.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class ContactOfficialCollectionSubpage extends StatefulWidget {
  final Contact contact;
  final Map pokemonNamesDict;
  ContactOfficialCollectionSubpage(this.contact, this.pokemonNamesDict);

  @override
  State<StatefulWidget> createState() {
    return ContactOfficialCollectionSubpageState(this.contact, this.pokemonNamesDict);
  }
}

class ContactOfficialCollectionSubpageState extends State<ContactOfficialCollectionSubpage> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Contact contact;
  Map pokemonNamesDict;

  Map pokemonNamesDictCopy;
  Map shinyDict;
  int navIndex;

  Widget appBarTitle;
  Icon searchIcon;

  TextEditingController textEditController;
  List<String> searchResult;
  bool isSearching;
  String searchText;

  // gender
  List<dynamic> pokemonGenderDict;

  ContactOfficialCollectionSubpageState(this.contact, this.pokemonNamesDict) {
    this.pokemonNamesDictCopy = new Map.from(this.pokemonNamesDict);
    this.shinyDict = new Map.from(this.pokemonNamesDict);

    this.navIndex = 0;
    this.appBarTitle = Text(this.contact.accountName + languageFile['PAGE_CONTACTS']['PRIMARY_LIST_SUBPAGE']['TITLE']);
    this.searchIcon = Icon(Icons.search);
    this.textEditController = new TextEditingController();
    this.searchResult = List<String>();
    this.isSearching = false;

    getCopyOfDict();

    // loading files
    loadGenderJson();

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

  void loadGenderJson() async {
    await rootBundle.loadString('json/official_collections/gender.json').then((genderDict) {
      this.pokemonGenderDict = jsonDecode(genderDict);
    });
  }

  void getCopyOfDict() {
    this.pokemonNamesDict.forEach((key, value) {
      if (key.contains('alolan')) {
        this.pokemonNamesDictCopy.remove(key);
      }
    });
  }

  String getShinyListString(Map dictCopy) {
    String copyToClipBoardString;

    for (int i = 0; i < this.contact.officialCollection.shinyList.length; i++) {
      String key = this.contact.officialCollection.shinyList[i];
      dictCopy.remove(key);
    }
    copyToClipBoardString = dictCopy.keys.toList().toString().replaceAll('[', '').replaceAll(']', '');
    return copyToClipBoardString;
  }

  String getCopyListString(List<String> pokemonList) {
    String myCopyString = '';
    List<int> tmpList = List<int>();
    List<dynamic> tmpList2 = new List.from(this.pokemonNamesDictCopy.keys.toList());

    pokemonList.forEach((element) {
      tmpList2.remove(element);
    });

    tmpList2.forEach((element) {
      tmpList.add(int.parse(element));
    });

    tmpList.sort();
    myCopyString = tmpList.join(',');

    return myCopyString;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> collectionPages = [
      luckySubPage(),
      shinySubpage(),
      genderSubpage(),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: backgroundColor,
        key: this.scaffoldKey,
        appBar: AppBar(
          title: this.appBarTitle,
          backgroundColor: appBarColor,
          actions: <Widget>[
            IconButton(
              icon: searchIcon,
              color: iconColor,
              onPressed: () => handleSearchEvent(),
            ),
            (navIndex < 2)
                ? IconButton(
                    icon: Icon(
                      Icons.content_copy,
                      color: iconColor,
                    ),
                    onPressed: () {
                      String copyToClipboardString;
                      this.navIndex == 0
                          ? copyToClipboardString = getCopyListString(this.contact.officialCollection.luckyList)
                          : copyToClipboardString = getCopyListString(this.contact.officialCollection.shinyList);
                      copyToClipboard(this.scaffoldKey, copyToClipboardString);
                    },
                  )
                : Text(''),
          ],
        ),
        body: collectionPages[this.navIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: backgroundColor,
            primaryColor: buttonColor,
            textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: subTextColor)),
          ),
          child: BottomNavigationBar(
            currentIndex: navIndex,
            onTap: (index) {
              setState(() {
                this.navIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.star),
                title: Text('Luckydex'),
              ),
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.flare),
                title: Text("Shinydex"),
              ),
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.genderMaleFemale),
                title: Text("Genderdex"),
              )
            ],
          ),
        ),
      ),
    );
  }

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
      for (int i = 0; i < this.pokemonNamesDictCopy.keys.toList().length; i++) {
        String pokemon = this.pokemonNamesDict[this.pokemonNamesDictCopy.keys.toList()[i]];
        if (pokemon.toLowerCase().contains(searchText.toLowerCase())) {
          String key = reversed[pokemon];
          searchResult.add(key);
        }
      }
      for (int i = 0; i < this.pokemonNamesDictCopy.values.toList().length; i++) {
        String nr = reversed[this.pokemonNamesDictCopy.values.toList()[i]];
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
        this.contact.accountName + languageFile['PAGE_CONTACTS']['PRIMARY_LIST_SUBPAGE']['TITLE'],
        style: new TextStyle(
          color: iconColor,
        ),
      );
      isSearching = false;
      textEditController.clear();
    });
  }

  Widget luckySubPage() {
    return Container(
      color: backgroundColor,
      child: this.searchResult.length != 0 || this.textEditController.text.isNotEmpty
          ? GridView.builder(
              itemCount: this.searchResult.length,
              padding: EdgeInsets.fromLTRB(20, 10, 5, 0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
              itemBuilder: (context, i) {
                String idx = this.searchResult[i];
                return GridTile(
                  child: showLucky(idx),
                );
              },
            )
          : GridView.builder(
              itemCount: this.pokemonNamesDictCopy.keys.length,
              padding: EdgeInsets.fromLTRB(20, 10, 5, 0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
              itemBuilder: (context, i) {
                String idx = this.pokemonNamesDictCopy.keys.toList()[i];
                return GridTile(
                  child: showLucky(idx),
                );
              },
            ),
    );
  }

  Widget shinySubpage() {
    return Container(
      color: backgroundColor,
      child: this.searchResult.length != 0 || this.textEditController.text.isNotEmpty
          ? GridView.builder(
              itemCount: this.searchResult.length,
              padding: EdgeInsets.fromLTRB(20, 10, 5, 0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
              itemBuilder: (context, i) {
                String idx = this.searchResult[i];
                return GridTile(
                  child: showShiny(idx),
                );
              },
            )
          : GridView.builder(
              itemCount: this.pokemonNamesDictCopy.keys.length,
              padding: EdgeInsets.fromLTRB(20, 10, 5, 0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
              itemBuilder: (context, i) {
                String idx = this.pokemonNamesDictCopy.keys.toList()[i];
                return GridTile(
                  child: showShiny(idx),
                );
              },
            ),
    );
  }

  Widget genderSubpage() {
    return Container(
      color: backgroundColor,
      child: this.searchResult.length != 0 || this.textEditController.text.isNotEmpty
          ? GridView.builder(
              padding: EdgeInsets.fromLTRB(20, 10, 5, 0),
              itemCount: this.searchResult.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                mainAxisSpacing: 15.0,
              ),
              itemBuilder: (context, i) {
                String idx = this.searchResult[i];
                bool needPokemon = checkNeedPokemon(idx, this.contact.officialCollection.neutralList, i);
                return GridTile(
                  child: showGender(idx, needPokemon),
                  footer: getGender(i, idx),
                );
              },
            )
          : GridView.builder(
              padding: EdgeInsets.fromLTRB(20, 10, 5, 0),
              itemCount: this.pokemonNamesDictCopy.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                mainAxisSpacing: 15.0,
              ),
              itemBuilder: (context, i) {
                String idx = this.pokemonNamesDictCopy.keys.toList()[i];
                bool needPokemon = checkNeedPokemon(idx, this.contact.officialCollection.neutralList, i);
                return GridTile(
                  child: showGender(idx, needPokemon),
                  footer: getGender(i, idx),
                );
              },
            ),
    );
  }

  Widget showShiny(String idx) {
    return Stack(
      children: <Widget>[
        Image(
          color: this.contact.officialCollection.shinyList.contains(idx) ? null : silhouetteColor,
          image: AssetImage('assets_bundle/pokemon_icons_shiny/$idx.png'),
          height: 45.0,
          width: 45.0,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget showLucky(String idx) {
    return Stack(
      children: <Widget>[
        Image(
          color: this.contact.officialCollection.luckyList.contains(idx) ? null : silhouetteColor,
          image: AssetImage('assets_bundle/pokemon_icons_blank/$idx.png'),
          height: 45.0,
          width: 45.0,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget showGender(String idx, bool pokemonNeeded) {
    return Stack(
      children: <Widget>[
        Image(
          color: pokemonNeeded ? silhouetteColor : null,
          image: AssetImage('assets_bundle/pokemon_icons_blank/$idx.png'),
          height: 45.0,
          width: 45.0,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget getGender(int i, String idx) {
    List<String> currGender = this.pokemonGenderDict[i]['gender'].keys.toList();
    if (currGender.length == 2) {
      return Row(
        children: <Widget>[
          InkResponse(
            child: Icon(
              MdiIcons.genderMale,
              color: showMale(idx),
            ),
          ),
          InkResponse(
            child: Icon(
              MdiIcons.genderFemale,
              color: showFemale(idx),
            ),
          ),
        ],
      );
    } else {
      if (currGender[0] == 'malePercent') {
        return Row(
          children: <Widget>[
            InkResponse(
              child: Icon(
                MdiIcons.genderMale,
                color: showMale(idx),
              ),
            )
          ],
        );
      } else if (currGender[0] == 'femalePercent') {
        return InkResponse(
          child: Icon(
            MdiIcons.genderFemale,
            color: showFemale(idx),
          ),
        );
      } else if (currGender[0] == 'genderlessPercent') {
        return Row(
          children: <Widget>[
            InkResponse(
              child: Icon(
                Icons.radio_button_unchecked,
                color: showNeutral(idx),
              ),
            )
          ],
        );
      } else {
        return Text('');
      }
    }
  }

  Color showMale(String idx) {
    if (this.contact.officialCollection.maleList.contains(idx))
      return genderMaleColor;
    else
      return silhouetteColor;
  }

  Color showFemale(String idx) {
    if (this.contact.officialCollection.femaleList.contains(idx))
      return genderFemaleColor;
    else
      return silhouetteColor;
  }

  Color showNeutral(String idx) {
    if (this.contact.officialCollection.neutralList.contains(idx))
      return genderNeutralColor;
    else
      return silhouetteColor;
  }

  bool checkNeedPokemon(String idx, List<String> pokemonList, int i) {
    bool needPokemon = true;
    pokemonList.contains(idx) ? needPokemon = false : needPokemon = true;
    if (this.navIndex < 2) return needPokemon;

    List<String> genderList = this.pokemonGenderDict[i]['gender'].keys.toList();
    if (genderList.length == 2)
      this.contact.officialCollection.femaleList.contains(idx) && this.contact.officialCollection.maleList.contains(idx) ? needPokemon = false : needPokemon = true;
    else
      this.contact.officialCollection.femaleList.contains(idx) ||
              this.contact.officialCollection.maleList.contains(idx) ||
              this.contact.officialCollection.neutralList.contains(idx)
          ? needPokemon = false
          : needPokemon = true;
    return needPokemon;
  }
}
