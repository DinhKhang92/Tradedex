import 'package:flutter/material.dart';
import 'dart:core';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/pages/individual_collection/cubit/individual_cubit.dart';
import 'package:tradedex/pages/individual_collection/components/add_collection_dialog.dart';

class IndividualCollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndividualCollectionPageState();
}

class IndividualCollectionPageState extends State<IndividualCollectionPage> {
  final String alolanFile = 'assets/sprites/alolan/103_alolan.png';
  final String eventFile = 'assets/sprites/event/007_00_05_event.png';
  final String galarFile = 'assets/sprites/galar/083_galar.png';
  final String regionalFile = 'assets/sprites/regional/083.png';
  final String pokedexFile = 'assets/sprites/blank/493.png';
  final String purifiedFile = 'assets/imgs/purified.png';
  final String shadowFile = 'assets/imgs/shadow.png';
  final String spindaFile = 'assets/sprites/spinda/327_11.png';
  final String unownFile = 'assets/sprites/unown/201_11.png';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.TITLE')),
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
              onPressed: () => showDialog(context: context, builder: (_) => AddCollectionDialog()),
            ),
          ],
        ),
        body: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      color: backgroundColor,
      child: BlocBuilder<IndividualCubit, IndividualState>(
        builder: (context, state) {
          if (state is IndividualLoaded)
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(color: dividerColor),
              itemCount: state.collection.keys.length,
              itemBuilder: (context, i) {
                String collectionName = state.collection.keys.toList()[i];
                Individual collectionType = state.collection[collectionName]['type'];
                Map collectionGathered = Map.from(state.collection[collectionName]['collection'])..removeWhere((key, value) => value == false);
                int collectedLength = collectionGathered.values.length;
                int collectionLength = state.collection[collectionName]['collection'].values.length;

                return Dismissible(
                  direction: DismissDirection.endToStart,
                  key: Key(collectionName),
                  background: Container(
                    color: dismissibleColor,
                    child: ListTile(
                      title: Text(
                        AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.DELETE_COLLECTION'),
                        style: TextStyle(color: buttonTextColor),
                        textAlign: TextAlign.center,
                      ),
                      trailing: Icon(
                        Icons.delete,
                        color: buttonTextColor,
                      ),
                    ),
                  ),
                  onDismissed: (direction) => BlocProvider.of<IndividualCubit>(context).deleteCollection(collectionName),
                  // {
                  // this.myIndividualCollection.remove(key);
                  // deleteIndividualCollectionSingleListFirebase(key, this.myProfile);
                  // showSnackbar(context, key);
                  // },
                  child: ListTile(
                    leading: _buildCollectionIcon(collectionType),
                    title: Text(collectionName, style: TextStyle(color: textColor)),
                    trailing: Text(
                      "[$collectedLength/$collectionLength]",
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () => Navigator.of(context).pushNamed('/collection', arguments: collectionName),
                  ),
                );
              },
            );
          return Container();
        },
      ),
    );
  }

  Widget _buildCollectionIcon(Individual collectionType) {
    String img = _getImageFile(collectionType);

    return CircleAvatar(
      backgroundColor: Colors.grey[300],
      backgroundImage: AssetImage(img),
    );
  }

  String _getImageFile(Individual collectionType) {
    String img;
    if (collectionType == Individual.Alolan)
      img = this.alolanFile;
    else if (collectionType == Individual.Event)
      img = this.eventFile;
    else if (collectionType == Individual.Galar)
      img = this.galarFile;
    else if (collectionType == Individual.Regional)
      img = this.regionalFile;
    else if (collectionType == Individual.Pokedex)
      img = this.pokedexFile;
    else if (collectionType == Individual.Purified)
      img = this.purifiedFile;
    else if (collectionType == Individual.Shadow)
      img = this.shadowFile;
    else if (collectionType == Individual.Spinda)
      img = this.spindaFile;
    else if (collectionType == Individual.Unown)
      img = this.unownFile;
    else
      img = this.pokedexFile;

    return img;
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
