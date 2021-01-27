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
import 'package:tradedex/model/device.dart';
import 'package:flutter/services.dart';

class SecondaryPage extends StatefulWidget with Device {
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
        backgroundColor: Color(0xff242423),
        key: this._scaffoldKey,
        body: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildHeader(),
        SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: BlocBuilder<PokemonCubit, PokemonState>(
            builder: (context, state) {
              if (state is PokemonLoaded) {
                return Container(
                  height: Device.height - Device.safeAreaHeight - 135,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Container(
                      height: 6,
                    ),
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
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 12, left: 5, right: 5, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          Text(
            AppLocalizations.of(context).translate("PAGE_SECONDARY_LIST.TITLE"),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          BlocBuilder<PokemonCubit, PokemonState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  Icons.content_copy,
                  color: iconColor,
                ),
                onPressed: () => _copyToClipboard(state.secondaryPokemon),
              );
            },
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(Map secondaryPokemon) {
    String copyString = BlocProvider.of<PokemonCubit>(context).copyPrimary(secondaryPokemon);
    Clipboard.setData(ClipboardData(text: copyString));
    this._scaffoldKey.currentState.showSnackBar(_buildSnackbar());
  }

  Widget _buildRowElement(String pokemonKey) {
    String pokemonName = AppLocalizations.of(context).translate('POKEMON.$pokemonKey');
    String number = pokemonKey.split('_').first;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 1.5,
          color: Colors.white.withOpacity(0.20),
        ),
      ),
      child: ListTile(
        leading: getPokemonImage(pokemonKey),
        title: Text(
          "#$number $pokemonName",
          style: TextStyle(color: Colors.white),
        ),
        trailing: IconButton(
          icon: Icon(
            MdiIcons.hexagon,
            color: secondaryListColor,
          ),
          onPressed: () => BlocProvider.of<PokemonCubit>(context).toggleSecondary(pokemonKey),
        ),
      ),
    );
  }

  Widget _buildSnackbar() {
    return SnackBar(
      content: Text(AppLocalizations.of(context).translate('PAGE_SECONDARY_LIST.COPY_TO_CLIPBOARD')),
    );
  }
}
