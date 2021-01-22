import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/pages/official_collection/cubit/official_cubit.dart';

class ShinyPage extends StatelessWidget {
  final String shinyPath = 'assets_bundle/pokemon_icons_shiny/';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: BlocBuilder<OfficialCubit, OfficialState>(
        builder: (context, state) => GridView.builder(
          itemCount: state.pokemon.keys.length,
          padding: EdgeInsets.fromLTRB(20, 10, 5, 0),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
          itemBuilder: (context, i) {
            String pokemonKey = state.pokemon.keys.toList()[i];
            return GridTile(
              child: InkResponse(
                child: _buildGridElement(pokemonKey),
                onTap: () => BlocProvider.of<OfficialCubit>(context)
                    .toggleShiny(pokemonKey),
                // setState(() {
                //   pokemonNeeded
                //       ? myOfficialCollection.shinyList.add(idx)
                //       : myOfficialCollection.shinyList.remove(idx);
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
        BlocBuilder<OfficialCubit, OfficialState>(
          builder: (context, state) {
            return Image(
              color:
                  state.pokemon[pokemonKey]['shiny'] ? null : silhouetteColor,
              image: AssetImage(this.shinyPath + '$pokemonKey.png'),
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
