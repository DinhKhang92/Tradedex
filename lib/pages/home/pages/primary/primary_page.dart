import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/pages/home/cubit/pokemon_cubit.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:tradedex/components/pokemon_image.dart';
import 'package:tradedex/model/device.dart';
import 'package:flutter/services.dart';

class PrimaryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PrimaryPageState();
}

class PrimaryPageState extends State<PrimaryPage> with Device {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff242423),
      key: this._scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: BlocBuilder<PokemonCubit, PokemonState>(
              builder: (context, state) {
                return Container(
                  height: Device.height - Device.safeAreaTop - 77 - Device.safeAreaBottom,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Container(
                      height: 6,
                    ),
                    itemCount: state.primaryPokemon.length,
                    itemBuilder: (context, i) {
                      String pokemonKey = state.primaryPokemon.keys.toList()[i];
                      return _buildRowElement(pokemonKey);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
            AppLocalizations.of(context).translate("PAGE_PRIMARY_LIST.TITLE"),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          BlocBuilder<PokemonCubit, PokemonState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  Icons.content_copy,
                  color: iconColor,
                ),
                onPressed: () => _copyToClipboard(state.primaryPokemon),
              );
            },
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(Map primaryPokemon) {
    String copyString = BlocProvider.of<PokemonCubit>(context).copyPrimary(primaryPokemon);
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
            Icons.favorite,
            color: Color(0xffee6c4d),
          ),
          onPressed: () => BlocProvider.of<PokemonCubit>(context).togglePrimary(pokemonKey),
        ),
      ),
    );
  }

  Widget _buildSnackbar() {
    return SnackBar(
      content: Text(AppLocalizations.of(context).translate('PAGE_PRIMARY_LIST.COPY_TO_CLIPBOARD')),
    );
  }
}
