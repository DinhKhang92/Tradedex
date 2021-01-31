import 'package:flutter/material.dart';
import 'dart:core';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/pages/individual_collection/cubit/individual_cubit.dart';
import 'package:tradedex/model/device.dart';
import 'package:flutter/services.dart';

class IndividualCollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndividualCollectionPageState();
}

class IndividualCollectionPageState extends State<IndividualCollectionPage> with Device {
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
  void initState() {
    super.initState();
    this._loadContext();
  }

  void _loadContext() {
    BlocProvider.of<IndividualCubit>(context).loadContext(context);
  }

  @override
  Widget build(BuildContext context) {
    this._loadDropdownList();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xff242423),
      body: _buildContent(),
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
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            height: Device.height - Device.safeAreaTop - 160 - Device.safeAreaBottom,
            child: BlocBuilder<IndividualCubit, IndividualState>(
              builder: (context, state) {
                if (state is IndividualLoaded) {
                  if (state.selectedValue.isEmpty) BlocProvider.of<IndividualCubit>(context).setSelectedValue(this.dropdownMap.values.first);
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    itemCount: state.collection.keys.length,
                    itemBuilder: (context, i) {
                      String collectionName = state.collection.keys.toList()[i];
                      Individual collectionType = state.collection[collectionName]['type'];
                      Map collectionGathered = Map.from(state.collection[collectionName]['collection'])..removeWhere((key, value) => value == false);
                      int collectedLength = collectionGathered.values.length;
                      int collectionLength = state.collection[collectionName]['collection'].values.length;

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            width: 1.5,
                            color: Colors.white.withOpacity(0.20),
                          ),
                        ),
                        child: InkWell(
                          onLongPress: () => BlocProvider.of<IndividualCubit>(context).deleteCollection(collectionName),
                          onTap: () => Navigator.of(context).pushNamed('/collection', arguments: collectionName),
                          child: GridTile(
                            header: Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 5, top: 5),
                                child: Text(
                                  "[$collectedLength/$collectionLength]",
                                  style: TextStyle(color: Color(0xffee6c4d)),
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _buildCollectionIcon(collectionType),
                                SizedBox(height: 8),
                                Padding(
                                  padding: EdgeInsets.only(right: 5, left: 5),
                                  child: Text(
                                    collectionName,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildCollectionNameInput(),
                SizedBox(width: 14),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      width: 1.5,
                      color: Colors.white.withOpacity(0.20),
                    ),
                  ),
                  child: BlocBuilder<IndividualCubit, IndividualState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () => _createList(state.selectedValue),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      );
                    },
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
      width: Device.width / 1.4,
      child: TextField(
        maxLength: 10,
        controller: this._textController,
        cursorColor: Color(0xff242423),
        decoration: InputDecoration(
          counterText: '',
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
          hintText: AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.ENTER_NAME'),
        ),
      ),
    );
  }

  void _createList(String selection) {
    Individual key = this.dropdownMap.keys.firstWhere((element) => this.dropdownMap[element] == selection);
    String collectionName = this._textController.text;
    BlocProvider.of<IndividualCubit>(context).addCollection(key, collectionName);

    FocusScope.of(context).unfocus();
    this._textController.clear();
  }

  Widget _buildCollectionIcon(Individual collectionType) {
    String img = _getImageFile(collectionType);

    return CircleAvatar(
      radius: Device.width / 15,
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
}
