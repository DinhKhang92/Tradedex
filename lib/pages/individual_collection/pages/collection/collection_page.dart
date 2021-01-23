import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/pages/individual_collection/cubit/individual_cubit.dart';

class CollectionPage extends StatefulWidget {
  final String collectionName;
  CollectionPage({@required this.collectionName});

  @override
  State<StatefulWidget> createState() => CollectionPageState(collectionName: this.collectionName);
}

class CollectionPageState extends State<CollectionPage> {
  final String collectionName;

  final String alolanPath = 'assets/sprites/alolan/';
  final String eventPath = 'assets/sprites/event/';
  final String galarPath = 'assets/sprites/galar/';
  final String regionalPath = 'assets/sprites/regional/';
  final String pokedexPath = 'assets/sprites/blank/';
  final String shadowPath = 'assets/sprites/blank/';
  final String spindaPath = 'assets/sprites/spinda/';
  final String unownPath = 'assets/sprites/unown/';

  CollectionPageState({@required this.collectionName});

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text(
            this.collectionName,
            style: TextStyle(color: titleColor),
          ),
          backgroundColor: appBarColor,
          actions: [
            IconButton(
              icon: Icon(MdiIcons.eyeOff, color: iconColor),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.remove_red_eye, color: iconColor),
              onPressed: () {},
            ),
          ],
        ),
        body: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      color: backgroundColor,
      child: BlocBuilder<IndividualCubit, IndividualState>(
        builder: (context, state) {
          int itemCount = state.collection[this.collectionName]['collection'].keys.length;
          return GridView.builder(
            itemCount: itemCount,
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
            itemBuilder: (context, i) {
              String pokemonKey = state.collection[this.collectionName]['collection'].keys.toList()[i];
              return GridTile(
                child: InkWell(
                  child: _buildGridElement(pokemonKey),
                  onTap: () => BlocProvider.of<IndividualCubit>(context).toggleCollection(collectionName, pokemonKey),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildGridElement(String pokemonKey) {
    return BlocBuilder<IndividualCubit, IndividualState>(
      builder: (context, state) {
        bool collected = state.collection[this.collectionName]['collection'][pokemonKey];
        String imgPath = _getImgPath(state);
        return Image(
          color: collected ? null : silhouetteColor,
          image: AssetImage(imgPath + '$pokemonKey.png'),
          fit: BoxFit.scaleDown,
        );
      },
    );
  }

  String _getImgPath(IndividualState state) {
    Individual type = state.collection[this.collectionName]['type'];

    if (type == Individual.Alolan)
      return this.alolanPath;
    else if (type == Individual.Event)
      return this.eventPath;
    else if (type == Individual.Galar)
      return this.galarPath;
    else if (type == Individual.Regional)
      return this.regionalPath;
    else if (type == Individual.Pokedex)
      return this.pokedexPath;
    else if (type == Individual.Shadow)
      return this.shadowPath;
    else if (type == Individual.Spinda)
      return this.spindaPath;
    else if (type == Individual.Unown)
      return this.unownPath;
    else
      return this.pokedexPath;
  }
}
