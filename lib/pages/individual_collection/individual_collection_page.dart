import 'package:flutter/material.dart';
import 'dart:core';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/pages/individual_collection/cubit/individual_cubit.dart';

class IndividualCollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndividualCollectionPageState();
}

class IndividualCollectionPageState extends State<IndividualCollectionPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  // @override
  // void initState() {
  //   loadIndividualCollectionFirebase(myProfile).then((individualCollection) {
  //     setState(() {
  //       this.myIndividualCollection = individualCollection;
  //     });
  //   });

  //   getCollectionLists();

  //   super.initState();
  // }

  // void getCollectionLists() async {
  //   await rootBundle
  //       .loadString("json/individual_collections/individual_collection.json")
  //       .then((String file) {
  //     Map individualCollectionFile = json.decode(file);
  //     for (String collection in individualCollectionFile.keys.toList()) {
  //       setState(() {
  //         if (collection ==
  //             rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']
  //                     ['ALOLAN']
  //                 .toLowerCase())
  //           this.alolanListTotal = individualCollectionFile[collection];
  //         else if (collection ==
  //             rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']
  //                     ['EVENT']
  //                 .toLowerCase())
  //           this.eventListTotal = individualCollectionFile[collection];
  //         else if (collection ==
  //             rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']
  //                     ['GALARIAN']
  //                 .toLowerCase())
  //           this.galarianListTotal = individualCollectionFile[collection];
  //         else if (collection ==
  //             rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']
  //                     ['REGIONAL']
  //                 .toLowerCase())
  //           this.regionalListTotal = individualCollectionFile[collection];
  //         else if (collection ==
  //             rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']
  //                     ['SPINDA']
  //                 .toLowerCase())
  //           this.spindaListTotal = individualCollectionFile[collection];
  //         else if (collection ==
  //             rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']
  //                     ['UNOWN']
  //                 .toLowerCase())
  //           this.unownListTotal = individualCollectionFile[collection];
  //         else {
  //           this.shadowListTotal = individualCollectionFile[collection];
  //           this.purifiedListTotal = individualCollectionFile[collection];
  //           this.pokedexListTotal = individualCollectionFile[collection];
  //         }
  //       });
  //     }
  //   });
  // }

  // int getListLength(String listType) {
  //   if (listType ==
  //       rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['ALOLAN'])
  //     return this.alolanListTotal.length;
  //   else if (listType ==
  //       rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['EVENT'])
  //     return this.eventListTotal.length;
  //   else if (listType ==
  //       rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']
  //           ['GALARIAN'])
  //     return this.galarianListTotal.length;
  //   else if (listType ==
  //       rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']
  //           ['REGIONAL'])
  //     return this.regionalListTotal.length;
  //   else if (listType ==
  //       rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['SPINDA'])
  //     return this.spindaListTotal.length;
  //   else if (listType ==
  //       rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['UNOWN'])
  //     return this.unownListTotal.length;
  //   else
  //     return this.pokedexListTotal.length;
  // }

  // void getListTypes() {
  //   for (String listType in languageFile['PAGE_INDIVIDUAL_COLLECTION']
  //           ['LIST_TYPES']
  //       .values
  //       .toList()) {
  //     this.listTypes.add(
  //           DropdownMenuItem(
  //             value: listType,
  //             child: Text(listType),
  //           ),
  //         );
  //   }
  // }

  // void callback(String selected) {
  //   setState(() {
  //     this.selectedListType = selected;
  //   });
  // }

  // void showDeleteDialog(BuildContext context) async {
  //   await showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: dialogBackgroundColor,
  //         title: Text(
  //           languageFile['PAGE_INDIVIDUAL_COLLECTION']['DIALOG_DELETE']
  //               ['TITLE'],
  //           style: TextStyle(color: buttonColor),
  //         ),
  //         content: Text(
  //           languageFile['PAGE_INDIVIDUAL_COLLECTION']['DIALOG_DELETE']
  //               ['DESCRIPTION'],
  //           style: TextStyle(color: textColor),
  //         ),
  //         actions: <Widget>[
  //           FlatButton(
  //               child: Text(
  //                 languageFile['PAGE_INDIVIDUAL_COLLECTION']['DIALOG_DELETE']
  //                     ['CANCEL'],
  //                 style: TextStyle(color: buttonColor),
  //               ),
  //               onPressed: () => Navigator.of(context).pop()),
  //           FlatButton(
  //             child: Text(
  //               languageFile['PAGE_INDIVIDUAL_COLLECTION']['DIALOG_DELETE']
  //                   ['ACCEPT'],
  //               style: TextStyle(color: buttonColor),
  //             ),
  //             onPressed: () {
  //               setState(() {
  //                 this.myIndividualCollection.clear();
  //               });
  //               deleteIndividualCollectionFirebase(this.myProfile);
  //               Navigator.of(context).pop();
  //             },
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  Map dropdownMap = new Map();

  void _loadDropdownList() {
    String alolan = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.ALOLAN');
    String pokedex = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.POKEDEX');
    String event = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.EVENT');
    String galar = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.GALAR');
    String regional = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.REGIONAL');
    String shadow = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.SHADOW');
    String spinda = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.SPINDA');
    String unown = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.UNOWN');

    this.dropdownMap[Individual.Alolan] = alolan;
    this.dropdownMap[Individual.Pokedex] = pokedex;
    this.dropdownMap[Individual.Event] = event;
    this.dropdownMap[Individual.Galar] = galar;
    this.dropdownMap[Individual.Regional] = regional;
    this.dropdownMap[Individual.Shadow] = shadow;
    this.dropdownMap[Individual.Spinda] = spinda;
    this.dropdownMap[Individual.Unown] = unown;

    BlocProvider.of<IndividualCubit>(context).loadDropdownList(this.dropdownMap);
  }

  @override
  Widget build(BuildContext context) {
    this._loadDropdownList();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.TITLE'),
        ),
        backgroundColor: appBarColor,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // setState(() {
              //   showDeleteDialog(context);
              // });
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => addDialog(),
          ),
        ],
      ),
      // body: individualCollectionPageBody(),
    );
  }

  // Widget individualCollectionPageBody() {
  //   // List<dynamic> sortedKeys = this.myIndividualCollection.keys.toList()
  //   //   ..sort();
  //   return Container(
  //     color: backgroundColor,
  //     child: ListView.separated(
  //       separatorBuilder: (context, index) => Container(
  //         child: Divider(
  //           color: dividerColor,
  //         ),
  //       ),
  //       itemCount: this.myIndividualCollection.length,
  //       itemBuilder: (context, i) {
  //         String key = sortedKeys.elementAt(i);
  //         String listType = this.myIndividualCollection[key]['listType'];
  //         return Dismissible(
  //           direction: DismissDirection.endToStart,
  //           key: Key(key),
  //           background: Container(
  //             color: dismissibleColor,
  //             child: ListTile(
  //               title: Text(
  //                 languageFile['PAGE_INDIVIDUAL_COLLECTION']
  //                     ['DELETE_COLLECTION'],
  //                 style: TextStyle(
  //                   color: buttonTextColor,
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //               trailing: Icon(
  //                 Icons.delete,
  //                 color: buttonTextColor,
  //               ),
  //             ),
  //           ),
  //           onDismissed: (direction) {
  //             this.myIndividualCollection.remove(key);
  //             deleteIndividualCollectionSingleListFirebase(key, this.myProfile);
  //             showSnackbar(context, key);
  //           },
  //           child: ListTile(
  //             // leading: getIcon(listType),
  //             title: Text(key, style: TextStyle(color: textColor)),
  //             trailing: Text(
  //               "[${this.myIndividualCollection[key]['list'].length}/${getListLength(listType)}]",
  //               style: TextStyle(color: textColor),
  //             ),
  //             // onTap: () => goToCollectionPage(listType, key, context),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // void updateLists(String currType) {
  //   String usdKey = languageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']
  //       .keys
  //       .firstWhere((k) =>
  //           languageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES'][k] ==
  //           currType);
  //   usdKey = usdKey[0].toUpperCase() + usdKey.substring(1).toLowerCase();
  //   // print("usdKey: " + usdKey);

  //   setState(() {
  //     this.myIndividualCollection[listNameController.text] = {
  //       'listType': usdKey,
  //       'list': new List<String>()
  //     };
  //   });
  // }

  void addDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: dialogBackgroundColor,
        title: Text(
          AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.DIALOG_ADD.TITLE'),
          style: TextStyle(color: textColor),
        ),
        content: Column(
          children: [
            _buildTypeDropdownElement(),
            ListTile(
              leading: Text(
                AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.DIALOG_ADD.NAME'),
                style: TextStyle(color: textColor),
              ),
              title: Form(
                key: this._formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty)
                      return languageFile['PAGE_CONTACTS']['INVALID_NAME'];
                    else
                      return null;
                  },
                  style: TextStyle(color: textColor),
                  // controller: listNameController,
                  cursorColor: buttonColor,
                  decoration: InputDecoration.collapsed(
                    hintText: AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.DIALOG_ADD.ENTER_NAME'),
                    hintStyle: TextStyle(fontSize: 14, color: textColor),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          FlatButton(
            child: Text(
              AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.DIALOG_ADD.CLOSE'),
              style: TextStyle(color: buttonColor),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          BlocBuilder<IndividualCubit, IndividualState>(
            builder: (context, state) {
              return FlatButton(
                child: Text(
                  AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.DIALOG_ADD.CREATE'),
                  style: TextStyle(color: buttonColor),
                ),
                onPressed: () => this._formKey.currentState.validate() ? _createList(state.dropdownValue) : {},
                // print(state.dropdownValue);
                // Individual key = this.dropdownMap.keys.firstWhere((element) => this.dropdownMap[element] == state.dropdownValue);
                // print(key);

                // if (this.formKey.currentState.validate()) {
                //   updateLists(this.selectedListType);
                //   saveIndividualCollectionFirebase(
                //       this.myIndividualCollection, this.myProfile);
                //   listNameController.clear();
                //   Navigator.of(context).pop();
                // }
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTypeDropdownElement() {
    return ListTile(
      leading: Text(
        AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.DIALOG_ADD.TYPE'),
        style: TextStyle(color: textColor),
      ),
      title: _buildDialogDropdown(),
    );
  }

  Widget _buildDialogDropdown() {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: dialogBackgroundColor),
      child: DropdownButtonHideUnderline(
        child: BlocBuilder<IndividualCubit, IndividualState>(
          builder: (context, state) {
            return DropdownButton(
              iconEnabledColor: textColor,
              style: TextStyle(color: textColor),
              value: state.dropdownValue,
              items: state.dropdownList,
              onChanged: (type) => BlocProvider.of<IndividualCubit>(context).setDropdownValue(type),
            );
          },
        ),
      ),
    );
  }

  void _createList(String selection) {
    print(selection);
    Individual key = this.dropdownMap.keys.firstWhere((element) => this.dropdownMap[element] == selection);
    print(key);
    Navigator.of(context).pop();
  }

  // void goToCollectionPage(String listType, String key, BuildContext context) {
  //   if (listType ==
  //       rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']
  //           ['ALOLAN']) {
  //     final result = Navigator.of(context).push(
  //       MaterialPageRoute<List<String>>(
  //         builder: (context) => AlolanSubpage(
  //             this.myIndividualCollection[key]['list'],
  //             this.alolanListTotal,
  //             key,
  //             this.myProfile),
  //       ),
  //     );
  //     result.then((resultList) {
  //       setState(() {
  //         this.alolanList = resultList;
  //       });
  //     });
  //   } else if (listType ==
  //       rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['EVENT']) {
  //     final result = Navigator.of(context).push(
  //       MaterialPageRoute<List<String>>(
  //         builder: (context) => EventSubpage(
  //             this.myIndividualCollection[key]['list'],
  //             this.eventListTotal,
  //             key,
  //             this.myProfile),
  //       ),
  //     );
  //     result.then((resultList) {
  //       setState(() {
  //         this.eventList = resultList;
  //       });
  //     });
  //   } else if (listType ==
  //       rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']
  //           ['GALARIAN']) {
  //     final result = Navigator.of(context).push(
  //       MaterialPageRoute<List<String>>(
  //         builder: (context) => GalarianSubpage(
  //             this.myIndividualCollection[key]['list'],
  //             this.galarianListTotal,
  //             key,
  //             this.myProfile),
  //       ),
  //     );
  //     result.then((resultList) {
  //       setState(() {
  //         this.galarianList = resultList;
  //       });
  //     });
  //   } else if (listType ==
  //       rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']
  //           ['REGIONAL']) {
  //     final result = Navigator.of(context).push(
  //       MaterialPageRoute<List<String>>(
  //         builder: (context) => RegionalSubpage(
  //             this.myIndividualCollection[key]['list'],
  //             this.regionalListTotal,
  //             key,
  //             this.myProfile),
  //       ),
  //     );
  //     result.then((resultList) {
  //       setState(() {
  //         this.regionalList = resultList;
  //       });
  //     });
  //   } else if (listType ==
  //       rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']
  //           ['SPINDA']) {
  //     final result = Navigator.of(context).push(
  //       MaterialPageRoute<List<String>>(
  //         builder: (context) => SpindaSubpage(
  //             this.myIndividualCollection[key]['list'],
  //             this.spindaListTotal,
  //             key,
  //             this.myProfile),
  //       ),
  //     );
  //     result.then((resultList) {
  //       setState(() {
  //         this.spindaList = resultList;
  //       });
  //     });
  //   } else if (listType ==
  //       rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['UNOWN']) {
  //     final result = Navigator.of(context).push(
  //       MaterialPageRoute<List<String>>(
  //         builder: (context) => UnownSubpage(
  //             this.myIndividualCollection[key]['list'],
  //             this.unownListTotal,
  //             key,
  //             this.myProfile),
  //       ),
  //     );
  //     result.then((resultList) {
  //       setState(() {
  //         this.unownList = resultList;
  //       });
  //     });
  //   } else if (listType ==
  //       rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']
  //           ['SHADOW']) {
  //     final result = Navigator.of(context).push(
  //       MaterialPageRoute<List<String>>(
  //         builder: (context) => ShadowSubpage(
  //             this.myIndividualCollection[key]['list'],
  //             this.shadowListTotal,
  //             key,
  //             this.myProfile),
  //       ),
  //     );
  //     result.then((resultList) {
  //       setState(() {
  //         this.shadowList = resultList;
  //       });
  //     });
  //   } else if (listType ==
  //       rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']
  //           ['PURIFIED']) {
  //     final result = Navigator.of(context).push(
  //       MaterialPageRoute<List<String>>(
  //         builder: (context) => PurifiedSubpage(
  //             this.myIndividualCollection[key]['list'],
  //             this.purifiedListTotal,
  //             key,
  //             this.myProfile),
  //       ),
  //     );
  //     result.then((resultList) {
  //       setState(() {
  //         this.purifiedList = resultList;
  //       });
  //     });
  //   } else if (listType ==
  //       rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']
  //           ['POKÉDEX']) {
  //     final result = Navigator.of(context).push(
  //       MaterialPageRoute<List<String>>(
  //         builder: (context) => PokedexSubpage(
  //             this.myIndividualCollection[key]['list'],
  //             this.pokedexListTotal,
  //             key,
  //             this.myProfile),
  //       ),
  //     );
  //     result.then((resultList) {
  //       setState(() {
  //         this.pokedexList = resultList;
  //       });
  //     });
  //   }
  // }

  dynamic showSnackbar(BuildContext context, key) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("$key" + languageFile['PAGE_INDIVIDUAL_COLLECTION']['DELETED']),
        duration: Duration(milliseconds: 2000),
      ),
    );
  }
}
