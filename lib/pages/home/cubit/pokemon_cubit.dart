import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:meta/meta.dart';

import 'package:tradedex/model/pokemon.dart';
import 'package:tradedex/localization/app_localization.dart';

part 'pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  final String imgPath = 'assets/sprites';

  List<String> pokemonImgs = new List<String>();
  Map pokemonMap = new Map();
  Map filteredPokemonMap = new Map();
  Map primaryPokemonMap = new Map();
  Map secondaryPokemonMap = new Map();
  BuildContext context;

  PokemonCubit() : super(PokemonInitial());

  void loadPokemon(BuildContext context) async {
    this.context = context;

    emit(PokemonLoading());
    final String manifestJson = await DefaultAssetBundle.of(this.context).loadString('AssetManifest.json');
    this.pokemonImgs = json.decode(manifestJson).keys.where((String key) => key.startsWith(imgPath)).toList();

    this.pokemonMap = _getPokemonMap();
    this.filteredPokemonMap = new Map.from(this.pokemonMap);

    emit(PokemonLoaded(
      pokemon: this.filteredPokemonMap,
      primaryPokemon: this.primaryPokemonMap,
      secondaryPokemon: this.secondaryPokemonMap,
    ));
  }

  Map _getPokemonMap() {
    Map pokemonMap = new Map();

    for (String file in this.pokemonImgs) {
      if (file.contains('blank') || file.contains('alolan')) {
        bool isShiny = file.contains('shiny');
        if (!isShiny) {
          String img = file.split('/').last;
          String number = img.split('.').first;

          Pokemon pokemon = new Pokemon(number);

          pokemonMap[pokemon.number] = {
            'name': AppLocalizations.of(this.context).translate('POKEMON.${pokemon.number}'),
            'primary': pokemon.primary,
            'secondary': pokemon.secondary,
          };
        }
      }
    }
    return pokemonMap;
  }

  void togglePrimary(String key) {
    this.filteredPokemonMap[key]['primary'] = !this.filteredPokemonMap[key]['primary'];

    _changePrimaryMap();

    emit(PokemonLoaded(pokemon: this.filteredPokemonMap, primaryPokemon: this.primaryPokemonMap, secondaryPokemon: this.secondaryPokemonMap));
  }

  void _changePrimaryMap() {
    this.primaryPokemonMap = Map.from(this.filteredPokemonMap)
      ..removeWhere((k, v) {
        return v['primary'] == false;
      });
  }

  void toggleSecondary(String key) {
    this.filteredPokemonMap[key]['secondary'] = !this.filteredPokemonMap[key]['secondary'];

    _changeSecondaryMap();

    emit(PokemonLoaded(
      pokemon: this.filteredPokemonMap,
      primaryPokemon: this.primaryPokemonMap,
      secondaryPokemon: this.secondaryPokemonMap,
    ));
  }

  void _changeSecondaryMap() {
    this.secondaryPokemonMap = Map.from(this.filteredPokemonMap)
      ..removeWhere((k, v) {
        return v['secondary'] == false;
      });
  }
}
