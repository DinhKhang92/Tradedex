import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:tradedex/model/pokemon.dart';

part 'official_state.dart';

class OfficialCubit extends Cubit<OfficialState> {
  final String imgPath = 'assets/sprites';

  List<String> pokemonImgs = new List<String>();
  Map pokemonMap = new Map();
  Map filteredPokemonMap = new Map();
  Map primaryPokemonMap = new Map();
  Map secondaryPokemonMap = new Map();
  BuildContext context;
  OfficialCubit() : super(OfficialInitial(navIdx: 0, pokemon: {}));

  void setNavIdx(int idx) =>
      emit(OfficialLoaded(navIdx: idx, pokemon: state.pokemon));

  void loadPokemon(BuildContext context) async {
    this.context = context;

    emit(OfficialLoading(navIdx: state.navIdx, pokemon: state.pokemon));
    final String manifestJson = await DefaultAssetBundle.of(this.context)
        .loadString('AssetManifest.json');
    this.pokemonImgs = json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith(imgPath))
        .toList();

    this.pokemonMap = _getPokemonMap();

    this.filteredPokemonMap = new Map.from(this.pokemonMap);

    emit(OfficialLoaded(
      navIdx: state.navIdx,
      pokemon: this.filteredPokemonMap,
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
            'name':
                AppLocalizations.of(this.context).translate('POKEMON.$number'),
            'lucky': false,
            'shiny': false,
          };
        }
      }
    }
    return pokemonMap;
  }

  void toggleLucky(String key) {
    this.filteredPokemonMap[key]['lucky'] =
        !this.filteredPokemonMap[key]['lucky'];
    emit(OfficialLoaded(
      navIdx: state.navIdx,
      pokemon: this.filteredPokemonMap,
    ));
  }

  void toggleShiny(String key) {
    this.filteredPokemonMap[key]['shiny'] =
        !this.filteredPokemonMap[key]['shiny'];
    emit(OfficialLoaded(
      navIdx: state.navIdx,
      pokemon: this.filteredPokemonMap,
    ));
  }
}
