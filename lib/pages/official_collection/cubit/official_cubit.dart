import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tradedex/localization/app_localization.dart';

import 'package:tradedex/model/trainer.dart';
import 'package:firebase_database/firebase_database.dart';

part 'official_state.dart';

enum Official {
  Lucky,
  Shiny,
  Male,
  Female,
  Neutral,
}

class OfficialCubit extends Cubit<OfficialState> with Trainer {
  final String imgPath = 'assets/sprites';
  final String assetManifestFile = 'AssetManifest.json';
  final String genderFile = 'assets/official/gender.json';

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  List<String> pokemonImgs = new List<String>();
  Map pokemonMap = new Map();
  Map filteredPokemonMap = new Map();
  Map primaryPokemonMap = new Map();
  Map secondaryPokemonMap = new Map();
  Map genderPokemonMap = new Map();
  BuildContext context;

  OfficialCubit() : super(OfficialInitial(navIdx: 0, pokemon: {}, gender: {}));

  void setNavIdx(int idx) => emit(OfficialLoaded(navIdx: idx, pokemon: state.pokemon, gender: state.gender));

  void loadPokemon(BuildContext context) async {
    this.context = context;

    emit(OfficialLoading(navIdx: state.navIdx, pokemon: state.pokemon, gender: state.gender));
    final String manifestJson = await DefaultAssetBundle.of(this.context).loadString(assetManifestFile);
    this.pokemonImgs = json.decode(manifestJson).keys.where((String key) => key.startsWith(imgPath)).toList();

    this.pokemonMap = _getPokemonMap();

    this.filteredPokemonMap = new Map.from(this.pokemonMap);

    emit(OfficialLoaded(
      navIdx: state.navIdx,
      pokemon: this.filteredPokemonMap,
      gender: state.gender,
    ));
  }

  Map _getPokemonMap() {
    Map pokemonMap = new Map();

    for (String file in this.pokemonImgs) {
      bool isBlank = file.contains('blank');
      if (isBlank) {
        bool isShiny = file.contains('shiny');
        if (!isShiny) {
          String img = file.split('/').last;
          String number = img.split('.').first;

          pokemonMap[number] = {
            'name': AppLocalizations.of(this.context).translate('POKEMON.$number'),
            'lucky': false,
            'shiny': false,
          };
        }
      }
    }
    return pokemonMap;
  }

  void loadGender(BuildContext context) async {
    this.context = context;

    final String genderJson = await DefaultAssetBundle.of(this.context).loadString(this.genderFile);
    final Map genderMap = json.decode(genderJson);

    for (String key in genderMap.keys) {
      this.genderPokemonMap[key] = {};
      if (genderMap[key].containsKey('malePercent')) {
        this.genderPokemonMap[key]['male'] = false;
      }
      if (genderMap[key].containsKey('femalePercent')) {
        this.genderPokemonMap[key]['female'] = false;
      }
      if (genderMap[key].containsKey('genderlessPercent')) {
        this.genderPokemonMap[key]['neutral'] = false;
      }
    }

    emit(OfficialLoaded(
      navIdx: state.navIdx,
      pokemon: state.pokemon,
      gender: this.genderPokemonMap,
    ));
  }

  void toggleLuckyShiny(String key, Official type) {
    String officialKey;
    if (type == Official.Lucky)
      officialKey = 'lucky';
    else if (type == Official.Shiny)
      officialKey = 'shiny';
    else
      return;

    this.filteredPokemonMap[key][officialKey] = !this.filteredPokemonMap[key][officialKey];
    this._updateDatabase();

    emit(OfficialLoaded(
      navIdx: state.navIdx,
      pokemon: this.filteredPokemonMap,
      gender: state.gender,
    ));
  }

  void toggleGender(String key, Official type) {
    String genderKey;
    if (type == Official.Male)
      genderKey = 'male';
    else if (type == Official.Female)
      genderKey = 'female';
    else if (type == Official.Neutral)
      genderKey = 'neutral';
    else
      return;

    this.genderPokemonMap[key][genderKey] = !this.genderPokemonMap[key][genderKey];
    this._updateDatabase();

    emit(OfficialLoaded(
      navIdx: state.navIdx,
      pokemon: state.pokemon,
      gender: this.genderPokemonMap,
    ));
  }

  void _updateDatabase() {
    this._database.reference().child(Trainer.tc).child('pokemon').update({
      'official': {
        'lucky_shiny': this.filteredPokemonMap,
        'gender': this.genderPokemonMap,
      },
    });
  }
}
