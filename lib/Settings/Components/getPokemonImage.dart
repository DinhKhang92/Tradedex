import 'package:flutter/material.dart';

AssetImage getPokemonImage(String idx) {
  if (idx.contains('alolan') == false)
    return AssetImage('assets_bundle/pokemon_icons_blank/$idx.png');
  else
    return AssetImage('assets_bundle/pokemon_icons_alolan/$idx.png');
}
