import 'package:flutter/material.dart';
import 'package:tradedex/Global/GlobalConstants.dart';

AssetImage getListIcon(String listType) {
  if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['ALOLAN'])
    return AssetImage('assets_bundle/pokemon_icons_alolan/074_alolan.png');
  else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['EVENT'])
    return AssetImage('assets_bundle/pokemon_icons_event/172_00_04_event.png');
  else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['GALARIAN'])
    return AssetImage('assets_bundle/pokemon_icons_galarian/083_galarian.png');
  else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['POKEDEX'])
    return AssetImage('assets_bundle/pokemon_icons_blank/493.png');
  else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['REGIONAL'])
    return AssetImage('assets_bundle/pokemon_icons_regional/324.png');
  else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['SPINDA'])
    return AssetImage('assets_bundle/pokemon_icons_spinda/327_11.png');
  else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['UNOWN'])
    return AssetImage('assets_bundle/pokemon_icons_unown/201_14.png');
  else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['SHADOW'])
    return AssetImage('collection/ic_shadow.png');
  else if (listType == rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['PURIFIED'])
    return AssetImage('collection/ic_purified.png');
  else
    return AssetImage('collection/pokemon_icons_blank/001.png');
}

Widget getIcon(String listType) {
  return Container(
    height: 40,
    width: 40,
    decoration: new BoxDecoration(
      color: Colors.grey[300],
      shape: BoxShape.circle,
      image: new DecorationImage(
        fit: BoxFit.scaleDown,
        image: getListIcon(listType),
      ),
    ),
  );
}
