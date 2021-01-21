import 'package:flutter/material.dart';
import 'package:tradedex/Global/Components/copyToClipboard.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:async';
// import 'package:tradedex/Global/Components/getPokemonImage.dart';
import 'package:tradedex/Global/Components/Dialogs/deleteDialog.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/pages/home/cubit/pokemon_cubit.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:tradedex/components/pokemon_image.dart';

class SecondaryPage extends StatefulWidget {
  SecondaryPage();

  @override
  State<StatefulWidget> createState() {
    return SecondaryPageState();
  }
}

class SecondaryPageState extends State<SecondaryPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        key: this._scaffoldKey,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate('PAGE_SECONDARY_LIST.TITLE')),
          backgroundColor: appBarColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: iconColor,
              ),
              onPressed: () {
                // showDialog(context: context, barrierDismissible: false, builder: (context) => deleteDialog(context, this.myProfile.secondaryList)).then((pokemonList) {
                //   setState(() {
                //     this.myProfile.secondaryList = pokemonList;
                //   });
                //   savePokemonListsFirebase(myProfile);
                // });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.content_copy,
                color: iconColor,
              ),
              onPressed: () {
                // String copyToClipBoardString = getSecondaryListString();
                // copyToClipboard(this.scaffoldKey, copyToClipBoardString);
              },
            ),
          ],
        ),
        body: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return BlocBuilder<PokemonCubit, PokemonState>(
      builder: (context, state) {
        if (state is PokemonLoaded) {
          return Container(
            color: backgroundColor,
            child: ListView.builder(
              itemCount: state.secondaryPokemon.length,
              itemBuilder: (context, i) {
                String pokemonKey = state.secondaryPokemon.keys.toList()[i];
                return _buildRowElement(pokemonKey);
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildRowElement(String pokemonKey) {
    String pokemonName = AppLocalizations.of(context).translate('POKEMON.$pokemonKey');
    String number = pokemonKey.split('_').first;
    return ListTile(
      leading: getPokemonImage(pokemonKey),
      title: Text(
        "#$number $pokemonName",
        style: TextStyle(color: textColor),
      ),
      trailing: IconButton(
        icon: Icon(
          MdiIcons.hexagon,
          color: secondaryListColor,
        ),
        onPressed: () => BlocProvider.of<PokemonCubit>(context).toggleSecondary(pokemonKey),
      ),
    );
  }
}
