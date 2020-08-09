import 'package:flutter/material.dart';

Image getPokemonImage(String idx) {
  String pokemonType;
  idx.contains('_alolan') ? pokemonType = 'alolan' : pokemonType = 'blank';
  return Image(
    image: AssetImage('assets_bundle/pokemon_icons_' + pokemonType + '/$idx.png'),
    height: 40.0,
    width: 40.0,
    fit: BoxFit.cover,
  );
}

AssetImage getPokemonAssetImage(String idx) {
  if (idx.contains('alolan') == false)
    return AssetImage('assets_bundle/pokemon_icons_blank/$idx.png');
  else
    return AssetImage('assets_bundle/pokemon_icons_alolan/$idx.png');
}
