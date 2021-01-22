import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/pages/official_collection/cubit/official_cubit.dart';

class LuckyPage extends StatelessWidget {
  final String blankPath = 'assets_bundle/pokemon_icons_blank/';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: BlocBuilder<OfficialCubit, OfficialState>(
        builder: (contex, state) => GridView.builder(
          itemCount: state.pokemon.keys.length,
          padding: EdgeInsets.fromLTRB(20, 10, 5, 0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
          itemBuilder: (context, i) {
            String pokemonKey = state.pokemon.keys.toList()[i];
            return GridTile(
              child: InkResponse(
                child: _buildGridElement(pokemonKey),
                onTap: () => BlocProvider.of<OfficialCubit>(context).toggleLuckyShiny(pokemonKey, Official.Lucky),
                // setState(() {
                //   pokemonNeeded
                //       ? myOfficialCollection.luckyList.add(idx)
                //       : myOfficialCollection.luckyList.remove(idx);
                // });
                // saveOfficialCollectionFirebase(
                //     this.myOfficialCollection, this.myProfile);
                // _saveLuckyList();
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGridElement(String pokemonKey) {
    return Stack(
      children: <Widget>[
        Image(
          image: AssetImage('collection/ui_bg_lucky_pokemon_transparent.png'),
          height: 45.0,
          width: 45.0,
          fit: BoxFit.cover,
        ),
        BlocBuilder<OfficialCubit, OfficialState>(
          builder: (context, state) {
            return Image(
              color: state.pokemon[pokemonKey]['lucky'] ? null : silhouetteColor,
              image: AssetImage(this.blankPath + '$pokemonKey.png'),
              height: 45.0,
              width: 45.0,
              fit: BoxFit.cover,
            );
          },
        ),
      ],
    );
  }
}
