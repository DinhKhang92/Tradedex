import 'package:flutter/material.dart';
import 'package:tradedex/Global/Components/deleteDataFirebase.dart';
import 'package:tradedex/Global/Components/loadDataFirebase.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'Subpages/UnownSubpage.dart';
import 'Subpages/EventSubpage.dart';
import 'Subpages/AlolanSubpage.dart';
import 'Subpages/SpindaSubpage.dart';
import 'Subpages/RegionalSubpage.dart';
import 'Subpages/PokedexSubpage.dart';
import 'Subpages/ShadowSubpage.dart';
import 'Subpages/PurifiedSubpage.dart';
import 'Subpages/GalarianSubpage.dart';
import 'dart:core';
import 'dart:convert';
import 'Components/getIcon.dart';
import 'package:flutter/services.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';

class IndividualCollectionPage extends StatefulWidget {
  final Profile myProfile;
  IndividualCollectionPage(this.myProfile);

  @override
  State<StatefulWidget> createState() {
    return IndividualCollectionPageState(this.myProfile);
  }
}

class IndividualCollectionPageState extends State<IndividualCollectionPage> {
  TextEditingController listNameController;
  List<DropdownMenuItem<String>> listTypes;
  String selectedListType;
  Map myIndividualCollection;
  final formKey = new GlobalKey<FormState>();

  Profile myProfile;

  // collection
  List<String> alolanList;
  List<String> eventList;
  List<String> galarianList;
  List<String> pokedexList;
  List<String> purifiedList;
  List<String> regionalList;
  List<String> shadowList;
  List<String> spindaList;
  List<String> unownList;

  // collection total
  List<dynamic> alolanListTotal;
  List<dynamic> eventListTotal;
  List<dynamic> galarianListTotal;
  List<dynamic> pokedexListTotal;
  List<dynamic> purifiedListTotal;
  List<dynamic> regionalListTotal;
  List<dynamic> shadowListTotal;
  List<dynamic> spindaListTotal;
  List<dynamic> unownListTotal;

  IndividualCollectionPageState(myProfile) {
    // collection
    this.alolanList = new List<String>();
    this.eventList = new List<String>();
    this.galarianList = new List<String>();
    this.pokedexList = new List<String>();
    this.purifiedList = new List<String>();
    this.regionalList = new List<String>();
    this.shadowList = new List<String>();
    this.spindaList = new List<String>();
    this.unownList = new List<String>();

    // collection total
    this.alolanListTotal = new List<dynamic>();
    this.eventListTotal = new List<dynamic>();
    this.galarianListTotal = new List<dynamic>();
    this.pokedexListTotal = new List<dynamic>();
    this.purifiedListTotal = new List<dynamic>();
    this.regionalListTotal = new List<dynamic>();
    this.shadowListTotal = new List<dynamic>();
    this.spindaListTotal = new List<dynamic>();
    this.unownListTotal = new List<dynamic>();

    this.myProfile = myProfile;
    this.listNameController = new TextEditingController();
    this.listTypes = new List<DropdownMenuItem<String>>();
    this.selectedListType = languageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['ALOLAN'];
    this.myIndividualCollection = new Map();

    getListTypes();
  }

  @override
  void initState() {
    loadIndividualCollectionFirebase(myProfile).then((individualCollection) {
      setState(() {
        this.myIndividualCollection = individualCollection;
      });
    });

    getCollectionLists();

    super.initState();
  }

  void getCollectionLists() async {
    await rootBundle.loadString("json/individual_collections/individual_collection.json").then((String file) {
      Map individualCollectionFile = json.decode(file);
      for (String collection in individualCollectionFile.keys.toList()) {
        setState(() {
          if (collection == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['ALOLAN'].toLowerCase())
            this.alolanListTotal = individualCollectionFile[collection];
          else if (collection == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['EVENT'].toLowerCase())
            this.eventListTotal = individualCollectionFile[collection];
          else if (collection == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['GALARIAN'].toLowerCase())
            this.galarianListTotal = individualCollectionFile[collection];
          else if (collection == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['REGIONAL'].toLowerCase())
            this.regionalListTotal = individualCollectionFile[collection];
          else if (collection == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['SPINDA'].toLowerCase())
            this.spindaListTotal = individualCollectionFile[collection];
          else if (collection == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['UNOWN'].toLowerCase())
            this.unownListTotal = individualCollectionFile[collection];
          else {
            this.shadowListTotal = individualCollectionFile[collection];
            this.purifiedListTotal = individualCollectionFile[collection];
            this.pokedexListTotal = individualCollectionFile[collection];
          }
        });
      }
    });
  }

  int getListLength(String listType) {
    if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['ALOLAN'])
      return this.alolanListTotal.length;
    else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['EVENT'])
      return this.eventListTotal.length;
    else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['GALARIAN'])
      return this.galarianListTotal.length;
    else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['REGIONAL'])
      return this.regionalListTotal.length;
    else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['SPINDA'])
      return this.spindaListTotal.length;
    else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['UNOWN'])
      return this.unownListTotal.length;
    else
      return this.pokedexListTotal.length;
  }

  void getListTypes() {
    for (String listType in languageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES'].values.toList()) {
      this.listTypes.add(
            DropdownMenuItem(
              value: listType,
              child: Text(listType),
            ),
          );
    }
  }

  void callback(String selected) {
    setState(() {
      this.selectedListType = selected;
    });
  }

  void showDeleteDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: dialogBackgroundColor,
          title: Text(
            languageFile['PAGE_INDIVIDUAL_COLLECTION']['DIALOG_DELETE']['TITLE'],
            style: TextStyle(color: buttonColor),
          ),
          content: Text(
            languageFile['PAGE_INDIVIDUAL_COLLECTION']['DIALOG_DELETE']['DESCRIPTION'],
            style: TextStyle(color: textColor),
          ),
          actions: <Widget>[
            FlatButton(
                child: Text(
                  languageFile['PAGE_INDIVIDUAL_COLLECTION']['DIALOG_DELETE']['CANCEL'],
                  style: TextStyle(color: buttonColor),
                ),
                onPressed: () => Navigator.of(context).pop()),
            FlatButton(
              child: Text(
                languageFile['PAGE_INDIVIDUAL_COLLECTION']['DIALOG_DELETE']['ACCEPT'],
                style: TextStyle(color: buttonColor),
              ),
              onPressed: () {
                setState(() {
                  this.myIndividualCollection.clear();
                });
                deleteIndividualCollectionFirebase(this.myProfile);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(languageFile['PAGE_INDIVIDUAL_COLLECTION']['TITLE']),
        backgroundColor: appBarColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                showDeleteDialog(context);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              addDialog(context);
            },
          ),
        ],
      ),
      body: individualCollectionPageBody(),
    );
  }

  Widget individualCollectionPageBody() {
    List<dynamic> sortedKeys = this.myIndividualCollection.keys.toList()..sort();
    return Container(
      color: backgroundColor,
      child: ListView.separated(
        separatorBuilder: (context, index) => Container(
          child: Divider(
            color: dividerColor,
          ),
        ),
        itemCount: this.myIndividualCollection.length,
        itemBuilder: (context, i) {
          String key = sortedKeys.elementAt(i);
          String listType = this.myIndividualCollection[key]['listType'];
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(key),
            background: Container(
              color: dismissibleColor,
              child: ListTile(
                title: Text(
                  languageFile['PAGE_INDIVIDUAL_COLLECTION']['DELETE_COLLECTION'],
                  style: TextStyle(
                    color: buttonTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                trailing: Icon(
                  Icons.delete,
                  color: buttonTextColor,
                ),
              ),
            ),
            onDismissed: (direction) {
              this.myIndividualCollection.remove(key);
              deleteIndividualCollectionSingleListFirebase(key, this.myProfile);
              showSnackbar(context, key);
            },
            child: ListTile(
              leading: getIcon(listType),
              title: Text(key, style: TextStyle(color: textColor)),
              trailing: Text(
                "[${this.myIndividualCollection[key]['list'].length}/${getListLength(listType)}]",
                style: TextStyle(color: textColor),
              ),
              onTap: () => goToCollectionPage(listType, key, context),
            ),
          );
        },
      ),
    );
  }

  void updateLists(String currType) {
    String usdKey = languageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES'].keys.firstWhere((k) => languageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES'][k] == currType);
    usdKey = usdKey[0].toUpperCase() + usdKey.substring(1).toLowerCase();
    print("usdKey: " + usdKey);

    setState(() {
      this.myIndividualCollection[listNameController.text] = {'listType': usdKey, 'list': new List<String>()};
    });
  }

  void addDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: dialogBackgroundColor,
          title: Text(
            languageFile['PAGE_INDIVIDUAL_COLLECTION']['DIALOG_ADD']['TITLE'],
            style: TextStyle(color: textColor),
          ),
          content: Column(
            children: <Widget>[
              ListTile(
                leading: Text(
                  languageFile['PAGE_INDIVIDUAL_COLLECTION']['DIALOG_ADD']['TYPE'],
                  style: TextStyle(color: textColor),
                ),
                title: AddDialogListType(this.callback, this.listTypes, this.selectedListType),
              ),
              ListTile(
                leading: Text(
                  languageFile['PAGE_INDIVIDUAL_COLLECTION']['DIALOG_ADD']['NAME'],
                  style: TextStyle(color: textColor),
                ),
                title: Form(
                  key: this.formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty)
                        return languageFile['PAGE_CONTACTS']['INVALID_NAME'];
                      else
                        return null;
                    },
                    style: TextStyle(color: textColor),
                    controller: listNameController,
                    cursorColor: buttonColor,
                    decoration: InputDecoration.collapsed(
                      hintText: languageFile['PAGE_INDIVIDUAL_COLLECTION']['DIALOG_ADD']['ENTER_NAME'],
                      hintStyle: TextStyle(fontSize: 14, color: textColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                languageFile['PAGE_INDIVIDUAL_COLLECTION']['DIALOG_ADD']['CLOSE'],
                style: TextStyle(color: buttonColor),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text(
                languageFile['PAGE_INDIVIDUAL_COLLECTION']['DIALOG_ADD']['CREATE'],
                style: TextStyle(color: buttonColor),
              ),
              onPressed: () {
                if (this.formKey.currentState.validate()) {
                  updateLists(this.selectedListType);
                  saveIndividualCollectionFirebase(this.myIndividualCollection, this.myProfile);
                  listNameController.clear();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void goToCollectionPage(String listType, String key, BuildContext context) {
    if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['ALOLAN']) {
      final result = Navigator.of(context).push(
        MaterialPageRoute<List<String>>(
          builder: (context) => AlolanSubpage(this.myIndividualCollection[key]['list'], this.alolanListTotal, key, this.myProfile),
        ),
      );
      result.then((resultList) {
        setState(() {
          this.alolanList = resultList;
        });
      });
    } else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['EVENT']) {
      final result = Navigator.of(context).push(
        MaterialPageRoute<List<String>>(
          builder: (context) => EventSubpage(this.myIndividualCollection[key]['list'], this.eventListTotal, key, this.myProfile),
        ),
      );
      result.then((resultList) {
        setState(() {
          this.eventList = resultList;
        });
      });
    } else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['GALARIAN']) {
      final result = Navigator.of(context).push(
        MaterialPageRoute<List<String>>(
          builder: (context) => GalarianSubpage(this.myIndividualCollection[key]['list'], this.galarianListTotal, key, this.myProfile),
        ),
      );
      result.then((resultList) {
        setState(() {
          this.galarianList = resultList;
        });
      });
    } else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['REGIONAL']) {
      final result = Navigator.of(context).push(
        MaterialPageRoute<List<String>>(
          builder: (context) => RegionalSubpage(this.myIndividualCollection[key]['list'], this.regionalListTotal, key, this.myProfile),
        ),
      );
      result.then((resultList) {
        setState(() {
          this.regionalList = resultList;
        });
      });
    } else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['SPINDA']) {
      final result = Navigator.of(context).push(
        MaterialPageRoute<List<String>>(
          builder: (context) => SpindaSubpage(this.myIndividualCollection[key]['list'], this.spindaListTotal, key, this.myProfile),
        ),
      );
      result.then((resultList) {
        setState(() {
          this.spindaList = resultList;
        });
      });
    } else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['UNOWN']) {
      final result = Navigator.of(context).push(
        MaterialPageRoute<List<String>>(
          builder: (context) => UnownSubpage(this.myIndividualCollection[key]['list'], this.unownListTotal, key, this.myProfile),
        ),
      );
      result.then((resultList) {
        setState(() {
          this.unownList = resultList;
        });
      });
    } else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['SHADOW']) {
      final result = Navigator.of(context).push(
        MaterialPageRoute<List<String>>(
          builder: (context) => ShadowSubpage(this.myIndividualCollection[key]['list'], this.shadowListTotal, key, this.myProfile),
        ),
      );
      result.then((resultList) {
        setState(() {
          this.shadowList = resultList;
        });
      });
    } else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['PURIFIED']) {
      final result = Navigator.of(context).push(
        MaterialPageRoute<List<String>>(
          builder: (context) => PurifiedSubpage(this.myIndividualCollection[key]['list'], this.purifiedListTotal, key, this.myProfile),
        ),
      );
      result.then((resultList) {
        setState(() {
          this.purifiedList = resultList;
        });
      });
    } else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['POKÉDEX']) {
      final result = Navigator.of(context).push(
        MaterialPageRoute<List<String>>(
          builder: (context) => PokedexSubpage(this.myIndividualCollection[key]['list'], this.pokedexListTotal, key, this.myProfile),
        ),
      );
      result.then((resultList) {
        setState(() {
          this.pokedexList = resultList;
        });
      });
    }
  }

  dynamic showSnackbar(BuildContext context, key) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("$key" + languageFile['PAGE_INDIVIDUAL_COLLECTION']['DELETED']),
        duration: Duration(milliseconds: 2000),
      ),
    );
  }
}

class AddDialogListType extends StatefulWidget {
  final Function callback;
  final List<DropdownMenuItem<String>> listTypes;
  final String selectedListType;
  AddDialogListType(this.callback, this.listTypes, this.selectedListType);

  @override
  State<StatefulWidget> createState() {
    return AddDialogListTypeState(this.callback, this.listTypes, this.selectedListType);
  }
}

class AddDialogListTypeState extends State<AddDialogListType> {
  Function callback;
  List<DropdownMenuItem<String>> listTypes;
  String selectedListType;

  AddDialogListTypeState(callback, listTypes, selectedListType) {
    this.callback = callback;
    this.listTypes = listTypes;
    this.selectedListType = selectedListType;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: dialogBackgroundColor,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          iconEnabledColor: textColor,
          style: TextStyle(color: textColor),
          value: this.selectedListType,
          items: this.listTypes,
          onChanged: (String selected) {
            setState(() {
              this.callback(selected);
              this.selectedListType = selected;
            });
          },
        ),
      ),
    );
  }
}
