import 'package:flutter/material.dart';

Widget getPokemonImage(String key) {
  bool isAlolan = key.contains('alolan');
  if (isAlolan)
    return Image(image: AssetImage('assets_bundle/pokemon_icons_alolan/$key.png'));
  else
    return Image(image: AssetImage('assets_bundle/pokemon_icons_blank/$key.png'));
}
