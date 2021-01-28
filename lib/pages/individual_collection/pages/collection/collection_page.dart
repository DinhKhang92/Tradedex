import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/pages/individual_collection/cubit/individual_cubit.dart';
import 'package:tradedex/model/device.dart';
import 'package:tradedex/localization/app_localization.dart';

class CollectionPage extends StatefulWidget {
  final String collectionName;
  CollectionPage({@required this.collectionName});

  @override
  State<StatefulWidget> createState() => CollectionPageState(collectionName: this.collectionName);
}

class CollectionPageState extends State<CollectionPage> with Device {
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
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xff242423),
        body: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildHeader(),
        Container(
          padding: EdgeInsets.only(left: 8, right: 8),
          height: Device.height - Device.safeAreaHeight - 80,
          child: BlocBuilder<IndividualCubit, IndividualState>(
            builder: (context, state) {
              int itemCount = state.collection[this.collectionName]['collection'].keys.length;
              return GridView.builder(
                itemCount: itemCount,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
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
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
      child: Column(
        children: [
          _buildNavbar(),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildNavbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        Text(
          this.collectionName,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Container(
          width: 48,
          height: 48,
          padding: EdgeInsets.all(8),
        ),
      ],
    );
  }

  Widget _buildGridElement(String pokemonKey) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 1.5,
          color: Colors.white.withOpacity(0.20),
        ),
      ),
      child: BlocBuilder<IndividualCubit, IndividualState>(
        builder: (context, state) {
          bool collected = state.collection[this.collectionName]['collection'][pokemonKey];
          String imgPath = _getImgPath(state);
          return Image(
            color: collected ? null : Colors.white.withOpacity(0.6),
            image: AssetImage(imgPath + '$pokemonKey.png'),
            fit: BoxFit.scaleDown,
          );
        },
      ),
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
