import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/pages/home/cubit/pokemon_cubit.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:tradedex/components/pokemon_image.dart';

class PrimaryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PrimaryPageState();
}

class PrimaryPageState extends State<PrimaryPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        key: this._scaffoldKey,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate('PAGE_PRIMARY_LIST.TITLE')),
          backgroundColor: appBarColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: iconColor,
              ),
              onPressed: () {
                // showDialog(context: context, barrierDismissible: false, builder: (context) => deleteDialog(context, this.myProfile.primaryList)).then((pokemonList) {
                //   setState(() {
                //     this.myProfile.primaryList = pokemonList;
                //   });
                //   savePokemonListsFirebase(myProfile);
                // });
              },
            ),
            IconButton(
              icon: Icon(
                MdiIcons.hexagon,
                color: iconColor,
              ),
              onPressed: () => Navigator.of(context).pushNamed('/secondary'),
            ),
            IconButton(
              icon: Icon(
                Icons.content_copy,
                color: iconColor,
              ),
              onPressed: () {
                // String copyToClipBoardString = getPrimaryListString();
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
              itemCount: state.primaryPokemon.length,
              itemBuilder: (context, i) {
                String pokemonKey = state.primaryPokemon.keys.toList()[i];
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
          Icons.favorite,
          color: primaryListColor,
        ),
        onPressed: () => BlocProvider.of<PokemonCubit>(context).togglePrimary(pokemonKey),
      ),
    );
  }
}
