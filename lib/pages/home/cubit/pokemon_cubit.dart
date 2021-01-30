import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:meta/meta.dart';

import 'package:tradedex/localization/app_localization.dart';
import 'package:tradedex/model/trainer.dart';
import 'package:firebase_database/firebase_database.dart';

part 'pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> with Trainer {
  final String imgPath = 'assets/sprites';

  final List<int> genAllInterval = [1, 809];
  final List<int> gen1Interval = [1, 151];
  final List<int> gen2Interval = [152, 251];
  final List<int> gen3Interval = [252, 386];
  final List<int> gen4Interval = [387, 493];
  final List<int> gen5Interval = [494, 649];
  final List<int> gen6Interval = [650, 721];
  final List<int> gen7Interval = [722, 809];
  final List<int> gen8Interval = [810, 898];

  List<String> pokemonImgs = new List<String>();
  Map pokemonMap = new Map();
  Map filteredPokemonMap = new Map();
  Map primaryPokemonMap = new Map();
  Map secondaryPokemonMap = new Map();
  BuildContext context;

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  PokemonCubit() : super(PokemonInitial(pokemon: {}, primaryPokemon: {}, secondaryPokemon: {}, gen: null));

  void loadPokemon(BuildContext context) async {
    this.context = context;

    emit(PokemonLoading(
      pokemon: state.pokemon,
      primaryPokemon: state.primaryPokemon,
      secondaryPokemon: state.secondaryPokemon,
      gen: state.gen,
    ));
    final String manifestJson = await DefaultAssetBundle.of(this.context).loadString('AssetManifest.json');
    this.pokemonImgs = json.decode(manifestJson).keys.where((String key) => key.startsWith(imgPath)).toList();

    this.pokemonMap = _getPokemonMap();
    this.filteredPokemonMap = new Map.from(this.pokemonMap);

    emit(PokemonLoaded(
      pokemon: this.filteredPokemonMap,
      primaryPokemon: this.primaryPokemonMap,
      secondaryPokemon: this.secondaryPokemonMap,
      gen: state.gen,
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

          pokemonMap[number] = {
            'name': AppLocalizations.of(this.context).translate('POKEMON.$number'),
            'primary': false,
            'secondary': false,
          };
        }
      }
    }
    return pokemonMap;
  }

  void togglePrimary(String key) {
    this.filteredPokemonMap[key]['primary'] = !this.filteredPokemonMap[key]['primary'];

    _changePrimaryMap();
    _updateDatabase();

    emit(PokemonLoaded(
      pokemon: this.filteredPokemonMap,
      primaryPokemon: this.primaryPokemonMap,
      secondaryPokemon: state.secondaryPokemon,
      gen: state.gen,
    ));
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
    _updateDatabase();

    emit(PokemonLoaded(
      pokemon: this.filteredPokemonMap,
      primaryPokemon: state.primaryPokemon,
      secondaryPokemon: this.secondaryPokemonMap,
      gen: state.gen,
    ));
  }

  void _changeSecondaryMap() {
    this.secondaryPokemonMap = Map.from(this.filteredPokemonMap)
      ..removeWhere((k, v) {
        return v['secondary'] == false;
      });
  }

  void searchPokemon(String searchText) {
    Iterable<dynamic> foundItemsByKey = this.pokemonMap.keys.where((dynamic key) => key.contains(searchText));
    Iterable<dynamic> foundItemsByVal = this.pokemonMap.keys.where((element) {
      String pokemonName = this.pokemonMap[element]['name'].toLowerCase();
      searchText = searchText.toLowerCase();
      return pokemonName.contains(searchText);
    });

    List<String> foundItems = [...foundItemsByKey.toList(), ...foundItemsByVal.toList()];

    this.filteredPokemonMap = new Map();
    for (String k in foundItems) {
      this.filteredPokemonMap[k] = this.pokemonMap[k];
    }

    emit(PokemonLoaded(
      pokemon: this.filteredPokemonMap,
      primaryPokemon: state.primaryPokemon,
      secondaryPokemon: state.secondaryPokemon,
      gen: state.gen,
    ));
  }

  void setGen(String gen) {
    String gen1 = AppLocalizations.of(context).translate('PAGE_HOME.GENS.GEN_1');
    String gen2 = AppLocalizations.of(context).translate('PAGE_HOME.GENS.GEN_2');
    String gen3 = AppLocalizations.of(context).translate('PAGE_HOME.GENS.GEN_3');
    String gen4 = AppLocalizations.of(context).translate('PAGE_HOME.GENS.GEN_4');
    String gen5 = AppLocalizations.of(context).translate('PAGE_HOME.GENS.GEN_5');
    String gen6 = AppLocalizations.of(context).translate('PAGE_HOME.GENS.GEN_6');
    String gen7 = AppLocalizations.of(context).translate('PAGE_HOME.GENS.GEN_7');

    List<int> genInterval = new List();
    if (gen == gen1)
      genInterval = this.gen1Interval;
    else if (gen == gen2)
      genInterval = this.gen2Interval;
    else if (gen == gen3)
      genInterval = this.gen3Interval;
    else if (gen == gen4)
      genInterval = this.gen4Interval;
    else if (gen == gen5)
      genInterval = this.gen5Interval;
    else if (gen == gen6)
      genInterval = this.gen6Interval;
    else if (gen == gen7)
      genInterval = this.gen7Interval;
    else
      genInterval = this.genAllInterval;

    _filterGenPokemon(genInterval);

    emit(PokemonLoaded(
      pokemon: this.filteredPokemonMap,
      primaryPokemon: state.primaryPokemon,
      secondaryPokemon: state.secondaryPokemon,
      gen: gen,
    ));
  }

  void _filterGenPokemon(List<int> genInterval) {
    this.filteredPokemonMap = new Map();

    for (String key in this.pokemonMap.keys) {
      int nr = int.parse(key.split('_').first);
      bool isInGenInterval = genInterval.first <= nr && nr <= genInterval.last;
      if (isInGenInterval) {
        this.filteredPokemonMap[key] = this.pokemonMap[key];
      }
    }
  }

  String copyPrimary(Map pokemonMap) {
    String copyString = '';
    for (String key in pokemonMap.keys) {
      if (key.contains('alolan')) continue;
      copyString += int.parse(key).toString() + ',';
    }
    return copyString;
  }

  void _updateDatabase() {
    this._database.reference().child(Trainer.tc).child('pokemon').update({
      'trade': this.pokemonMap,
    });
  }

  void dispose() {
    this.close();
  }
}
