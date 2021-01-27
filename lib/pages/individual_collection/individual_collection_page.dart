import 'package:flutter/material.dart';
import 'dart:core';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/pages/individual_collection/cubit/individual_cubit.dart';
import 'package:tradedex/model/device.dart';

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

  final TextEditingController _textController = new TextEditingController();
  Map dropdownMap = new Map();

  @override
  Widget build(BuildContext context) {
    this._loadDropdownList();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xff242423),
        body: _buildContent(),
      ),
    );
  }

  void _loadDropdownList() {
    String alolan = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.ALOLAN');
    String event = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.EVENT');
    String galar = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.GALAR');
    String pokedex = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.POKEDEX');
    String purified = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.PURIFIED');
    String regional = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.REGIONAL');
    String shadow = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.SHADOW');
    String spinda = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.SPINDA');
    String unown = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.UNOWN');

    this.dropdownMap[Individual.Alolan] = alolan;
    this.dropdownMap[Individual.Event] = event;
    this.dropdownMap[Individual.Galar] = galar;
    this.dropdownMap[Individual.Pokedex] = pokedex;
    this.dropdownMap[Individual.Purified] = purified;
    this.dropdownMap[Individual.Regional] = regional;
    this.dropdownMap[Individual.Shadow] = shadow;
    this.dropdownMap[Individual.Spinda] = spinda;
    this.dropdownMap[Individual.Unown] = unown;

    BlocProvider.of<IndividualCubit>(context).loadDropdownList(this.dropdownMap);
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildHeader(),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.only(left: 8, right: 8),
          height: Device.height - Device.safeAreaHeight - 177,
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
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 12),
      child: Column(
        children: [
          _buildNavbar(),
          SizedBox(height: 5),
          Container(
            height: 50,
            width: Device.width - 26,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                BlocBuilder<IndividualCubit, IndividualState>(
                  builder: (context, state) {
                    return Wrap(
                      spacing: 8,
                      children: state.typeMap.values.map((v) => _buildChip(v)).toList(),
                    );
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCollectionNameInput(),
                Container(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        Text(
          AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.TITLE'),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        IconButton(
          icon: Icon(
            Icons.content_copy,
            color: Colors.white,
          ),
          onPressed: () => {},
        ),
      ],
    );
  }

  Widget _buildChip(String title) {
    return BlocBuilder<IndividualCubit, IndividualState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => BlocProvider.of<IndividualCubit>(context).setSelectedValue(title),
          child: Chip(
            padding: EdgeInsets.only(left: 7, right: 7),
            label: Text(title),
            backgroundColor: state.selectedValue == title ? Color(0xffee6c4d) : Colors.white,
          ),
        );
      },
    );
  }

  Widget _buildCollectionNameInput() {
    return Container(
      height: 30,
      width: Device.width / 1.7,
      child: TextField(
        controller: this._textController,
        cursorColor: Color(0xff242423),
        onChanged: (value) => {},
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(32.0),
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 0, 0.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(32.0),
          ),
          hintText: "Name ...",
        ),
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
