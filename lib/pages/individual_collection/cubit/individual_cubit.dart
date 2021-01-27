import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:core';
import 'dart:async';

part 'individual_state.dart';

enum Individual {
  Alolan,
  Event,
  Galar,
  Regional,
  Pokedex,
  Purified,
  Shadow,
  Spinda,
  Unown,
}

class IndividualCubit extends Cubit<IndividualState> {
  BuildContext context;
  String recentCollectionName = '';
  Map collection = new Map();

  final String imgPath = 'assets/sprites';

  List<String> pokemonImgs = new List<String>();

  IndividualCubit() : super(IndividualInitial(selectedValue: '', collection: {}, typeMap: {}));

  void loadContext(BuildContext context) {
    this.context = context;
  }

  void loadDropdownList(Map typeMap) => emit(IndividualLoaded(selectedValue: typeMap.values.first, collection: state.collection, typeMap: typeMap));

  void setSelectedValue(String val) => emit(IndividualLoaded(selectedValue: val, collection: state.collection, typeMap: state.typeMap));

  void setCollectionName(String name) => this.recentCollectionName = name;

  void addCollection(Individual type) async {
    this.collection[this.recentCollectionName] = {};
    this.collection[this.recentCollectionName]['type'] = type;

    Map newCollection = await _createCollection(type);
    this.collection[this.recentCollectionName]['collection'] = newCollection;

    emit(IndividualLoaded(
      selectedValue: state.selectedValue,
      collection: this.collection,
      typeMap: state.typeMap,
    ));
  }

  Future<Map> _createCollection(Individual type) async {
    Map collection = new Map();

    final String manifestJson = await DefaultAssetBundle.of(this.context).loadString('AssetManifest.json');
    this.pokemonImgs = json.decode(manifestJson).keys.where((String key) => key.startsWith(imgPath)).toList();

    String collectionType;
    if (type == Individual.Alolan)
      collectionType = 'alolan';
    else if (type == Individual.Event)
      collectionType = 'event';
    else if (type == Individual.Galar)
      collectionType = 'galar';
    else if (type == Individual.Regional)
      collectionType = 'regional';
    else if (type == Individual.Pokedex)
      collectionType = 'blank';
    else if (type == Individual.Purified)
      collectionType = 'blank';
    else if (type == Individual.Shadow)
      collectionType = 'blank';
    else if (type == Individual.Spinda)
      collectionType = 'spinda';
    else if (type == Individual.Unown)
      collectionType = 'unown';
    else
      return {};

    collection = _getPokemonMap(collectionType);
    return collection;
  }

  Map _getPokemonMap(String type) {
    Map pokemonMap = new Map();

    for (String file in this.pokemonImgs) {
      if (file.contains(type)) {
        String img = file.split('/').last;
        String number = img.split('.').first;

        pokemonMap[number] = false;
      }
    }
    return pokemonMap;
  }

  void deleteCollection(String collectionName) {
    this.collection.remove(collectionName);

    emit(IndividualLoaded(
      selectedValue: state.selectedValue,
      collection: this.collection,
      typeMap: state.typeMap,
    ));
  }

  void toggleCollection(String collectionName, String pokemonKey) {
    this.collection[collectionName]['collection'][pokemonKey] = !this.collection[collectionName]['collection'][pokemonKey];

    emit(IndividualLoaded(
      selectedValue: state.selectedValue,
      collection: this.collection,
      typeMap: state.typeMap,
    ));
  }
}
