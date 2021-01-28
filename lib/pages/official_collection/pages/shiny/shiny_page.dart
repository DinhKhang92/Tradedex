import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/pages/official_collection/cubit/official_cubit.dart';
import 'package:tradedex/model/device.dart';
import 'package:tradedex/localization/app_localization.dart';

class ShinyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShinyPageState();
}

class ShinyPageState extends State<ShinyPage> with Device {
  final String shinyPath = 'assets_bundle/pokemon_icons_shiny/';

  final TextEditingController _textController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.only(left: 8, right: 8),
          height: Device.height - Device.safeAreaHeight - 177,
          child: BlocBuilder<OfficialCubit, OfficialState>(
            builder: (context, state) => GridView.builder(
              itemCount: state.pokemon.keys.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemBuilder: (context, i) {
                String pokemonKey = state.pokemon.keys.toList()[i];
                return GridTile(
                  child: InkResponse(
                    child: _buildGridElement(pokemonKey),
                    onTap: () => BlocProvider.of<OfficialCubit>(context).toggleLuckyShiny(pokemonKey, Official.Shiny),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 12),
      child: Column(
        children: [
          _buildNavbar(),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSearchbar(),
              ],
            ),
          ),
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
          AppLocalizations.of(context).translate('PAGE_OFFICIAL_COLLECTION.SHINYDEX.TITLE'),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        IconButton(
          icon: Icon(
            Icons.content_copy,
            color: Colors.white,
          ),
          onPressed: () => {},
        ),
      ],
    );
  }

  Widget _buildSearchbar() {
    return Container(
      height: 34,
      width: Device.width / 1.7,
      child: TextField(
        controller: this._textController,
        cursorColor: Color(0xff242423),
        onChanged: (value) => {},
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(32.0),
          ),
          isDense: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(32.0),
          ),
          suffixIcon: Icon(
            Icons.search,
            size: 20,
            color: Color(0xff242423),
          ),
        ),
      ),
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
      child: Center(
        child: BlocBuilder<OfficialCubit, OfficialState>(
          builder: (context, state) {
            return Image(
              color: state.pokemon[pokemonKey]['shiny'] ? null : Colors.white.withOpacity(0.6),
              image: AssetImage(this.shinyPath + '$pokemonKey.png'),
              height: 45.0,
              width: 45.0,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
