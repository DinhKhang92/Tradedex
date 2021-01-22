import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/pages/official_collection/cubit/official_cubit.dart';

class GenderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: BlocBuilder<OfficialCubit, OfficialState>(
        builder: (context, state) => GridView.builder(
          padding: EdgeInsets.fromLTRB(20, 10, 5, 0),
          itemCount: state.gender.keys.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            mainAxisSpacing: 15.0,
          ),
          itemBuilder: (context, i) {
            String pokemonKey = state.gender.keys.toList()[i];
            return GridTile(
              child: _buildGridElement(pokemonKey),
              footer: _buildGridFooter(pokemonKey),
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
            List<dynamic> genderValues = state.gender[pokemonKey].values.toList();
            bool completed = !genderValues.contains(false);
            return Image(
              color: completed ? null : silhouetteColor,
              image: AssetImage('assets_bundle/pokemon_icons_blank/$pokemonKey.png'),
              height: 45.0,
              width: 45.0,
              fit: BoxFit.cover,
            );
          },
        ),
      ],
    );
  }

  Widget _buildGridFooter(String pokemonKey) {
    return BlocBuilder<OfficialCubit, OfficialState>(
      builder: (context, state) {
        bool maleExists = state.gender[pokemonKey].containsKey('male');
        bool femaleExists = state.gender[pokemonKey].containsKey('female');
        bool neutralExists = state.gender[pokemonKey].containsKey('neutral');

        if (neutralExists)
          return _buildNeutralIcon(pokemonKey);
        else if (maleExists && femaleExists)
          return _buildMaleFemaleRow(pokemonKey);
        else if (maleExists)
          return _buildMaleIcon(pokemonKey);
        else if (femaleExists)
          return _buildFemaleIcon(pokemonKey);
        else
          return Container();
      },
    );
  }

  Widget _buildMaleFemaleRow(String pokemonKey) {
    return Row(
      children: [
        _buildMaleIcon(pokemonKey),
        _buildFemaleIcon(pokemonKey),
      ],
    );
  }

  Widget _buildMaleIcon(String pokemonKey) {
    return BlocBuilder<OfficialCubit, OfficialState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => BlocProvider.of<OfficialCubit>(context).toggleGender(pokemonKey, Official.Male),
          child: Icon(
            MdiIcons.genderMale,
            color: state.gender[pokemonKey]['male'] ? genderMaleColor : silhouetteColor,
          ),
        );
      },
    );
  }

  Widget _buildFemaleIcon(String pokemonKey) {
    return BlocBuilder<OfficialCubit, OfficialState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => BlocProvider.of<OfficialCubit>(context).toggleGender(pokemonKey, Official.Female),
          child: Icon(
            MdiIcons.genderFemale,
            color: state.gender[pokemonKey]['female'] ? genderFemaleColor : silhouetteColor,
          ),
        );
      },
    );
  }

  Widget _buildNeutralIcon(String pokemonKey) {
    return BlocBuilder<OfficialCubit, OfficialState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => BlocProvider.of<OfficialCubit>(context).toggleGender(pokemonKey, Official.Neutral),
          child: Icon(
            Icons.radio_button_unchecked,
            color: state.gender[pokemonKey]['neutral'] ? genderNeutralColor : silhouetteColor,
          ),
        );
      },
    );
  }
}
