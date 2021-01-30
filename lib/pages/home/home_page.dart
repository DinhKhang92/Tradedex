import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/pages/home/cubit/pokemon_cubit.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:tradedex/components/pokemon_image.dart';
import 'package:tradedex/components/drawer.dart';
import 'dart:ui';
import 'package:tradedex/model/device.dart';

import 'package:flutter_picker/flutter_picker.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with Device {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _textController = new TextEditingController();
  String genAll;
  String gen1;
  String gen2;
  String gen3;
  String gen4;
  String gen5;
  String gen6;
  String gen7;

  @override
  void initState() {
    this._loadPokemon();
    super.initState();
  }

  void _loadPokemon() {
    BlocProvider.of<PokemonCubit>(context).loadPokemon(context);
  }

  @override
  Widget build(BuildContext context) {
    Device.safeAreaBottom = MediaQuery.of(context).padding.bottom;
    Device.safeAreaTop = MediaQuery.of(context).padding.top;
    Device.height = MediaQuery.of(context).size.height;
    Device.width = MediaQuery.of(context).size.width;
    this.readGens();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xff242423),
      key: this._scaffoldKey,
      drawer: DrawerComponent(),
      body: _buildContent(),
    );
  }

  void readGens() {
    this.genAll = AppLocalizations.of(context).translate('PAGE_HOME.GENS.GEN_ALL');
    this.gen1 = AppLocalizations.of(context).translate('PAGE_HOME.GENS.GEN_1');
    this.gen2 = AppLocalizations.of(context).translate('PAGE_HOME.GENS.GEN_2');
    this.gen3 = AppLocalizations.of(context).translate('PAGE_HOME.GENS.GEN_3');
    this.gen4 = AppLocalizations.of(context).translate('PAGE_HOME.GENS.GEN_4');
    this.gen5 = AppLocalizations.of(context).translate('PAGE_HOME.GENS.GEN_5');
    this.gen6 = AppLocalizations.of(context).translate('PAGE_HOME.GENS.GEN_6');
    this.gen7 = AppLocalizations.of(context).translate('PAGE_HOME.GENS.GEN_7');
  }

  Widget _buildContent() {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Container(
              height: Device.height - Device.safeAreaTop - 129 - Device.safeAreaBottom,
              child: BlocBuilder<PokemonCubit, PokemonState>(
                builder: (context, state) {
                  if (state is PokemonInitial)
                    return _buildInitial();
                  else if (state is PokemonLoading)
                    return _buildLoading();
                  else if (state is PokemonLoaded)
                    return _buildLoaded();
                  else
                    return _buildLoading();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 12, left: 5, right: 5, bottom: 12),
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
                _buildGenPicker(),
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
          onPressed: () => this._scaffoldKey.currentState.openDrawer(),
          icon: Icon(Icons.menu, color: Colors.white),
        ),
        Wrap(
          children: [
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.white),
              onPressed: () => Navigator.of(context).pushNamed('/primary'),
            ),
            IconButton(
              icon: Icon(MdiIcons.hexagon, color: Colors.white),
              onPressed: () => Navigator.of(context).pushNamed('/secondary'),
            )
          ],
        )
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
        onChanged: (value) => BlocProvider.of<PokemonCubit>(context).searchPokemon(value),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(32.0),
          ),
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 0, 0.0),
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

  Widget _buildGenPicker() {
    return InkWell(
      onTap: () => _showPicker(),
      child: Container(
        width: Device.width / 3.5,
        height: 32,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        padding: EdgeInsets.only(right: 10, left: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            width: 1.5,
            color: Colors.white.withOpacity(0.20),
          ),
        ),
        child: Center(
          child: BlocBuilder<PokemonCubit, PokemonState>(
            builder: (context, state) {
              return Text(
                state.gen ?? AppLocalizations.of(context).translate('PAGE_HOME.GENS.GEN_ALL'),
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showPicker() {
    FocusScope.of(context).unfocus();
    final List<String> pickerData = [
      this.genAll,
      this.gen1,
      this.gen2,
      this.gen3,
      this.gen4,
      this.gen5,
      this.gen6,
      this.gen7,
    ];

    Picker picker = Picker(
      adapter: PickerDataAdapter<String>(pickerdata: pickerData),
      changeToFirst: false,
      textAlign: TextAlign.left,
      textStyle: const TextStyle(color: Colors.white60, fontSize: 18),
      selectedTextStyle: TextStyle(color: Colors.white, fontSize: 18),
      columnPadding: const EdgeInsets.all(8.0),
      onConfirm: (Picker picker, List value) => _setGen(picker),
      cancelTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      confirmTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      backgroundColor: Color(0xff242423),
      containerColor: Color(0xff242423),
      headercolor: Color(0xff242423),
      confirmText: AppLocalizations.of(context).translate('PAGE_HOME.CONFIRM'),
      cancelText: AppLocalizations.of(context).translate('PAGE_HOME.CANCEL'),
    );
    picker.show(_scaffoldKey.currentState);
  }

  void _setGen(Picker picker) {
    String gen = picker.getSelectedValues().first;
    BlocProvider.of<PokemonCubit>(context).setGen(gen);
  }

  Widget _buildInitial() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildLoaded() {
    return BlocBuilder<PokemonCubit, PokemonState>(
      builder: (context, state) => Container(
        child: ListView.separated(
          separatorBuilder: (context, index) => Container(
            height: 6,
          ),
          itemCount: state.pokemon.length,
          itemBuilder: (context, i) {
            String pokemonKey = state.pokemon.keys.toList()[i];
            return _buildRowElement(pokemonKey);
          },
        ),
      ),
    );
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BlocBuilder<PokemonCubit, PokemonState>(
              builder: (context, state) {
                return IconButton(
                  icon: Icon(
                    state.pokemon[pokemonKey]['primary'] ? Icons.favorite : Icons.favorite_border,
                    color: Color(0xffee6c4d),
                  ),
                  onPressed: () => BlocProvider.of<PokemonCubit>(context).togglePrimary(pokemonKey),
                );
              },
            ),
            BlocBuilder<PokemonCubit, PokemonState>(
              builder: (context, state) => IconButton(
                icon: Icon(
                  state.pokemon[pokemonKey]['secondary'] ? MdiIcons.hexagon : MdiIcons.hexagonOutline,
                  color: secondaryListColor,
                ),
                onPressed: () => BlocProvider.of<PokemonCubit>(context).toggleSecondary(pokemonKey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
