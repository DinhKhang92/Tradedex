import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'contact_overview_state.dart';

class ContactOverviewCubit extends Cubit<ContactOverviewState> {
  ContactOverviewCubit() : super(ContactOverviewState(gridItemCount: 0, primaryMap: {}, secondaryMap: {}));

  void loadOverview(Map pokemonMap) {
    print("-loadOverview-");
    int itemCount = 0;

    Map tradeMap = new Map();
    Map primaryMap = new Map();
    Map secondaryMap = new Map();

    if (pokemonMap.keys.contains('trade')) {
      itemCount += 2;
      tradeMap = pokemonMap['trade'];
      primaryMap = this._getPrimary(tradeMap);
      secondaryMap = this._getSecondary(tradeMap);
    }
    print("primaryMap:  ");
    print(primaryMap);

    emit(ContactOverviewState(
      gridItemCount: itemCount,
      primaryMap: primaryMap,
      secondaryMap: secondaryMap,
    ));
  }

  Map _getPrimary(Map tradeMap) {
    Map primaryPokemon = Map.from(tradeMap)..removeWhere((key, value) => !value['primary']);
    return primaryPokemon;
  }

  Map _getSecondary(Map tradeMap) {
    Map primaryPokemon = Map.from(tradeMap)..removeWhere((key, value) => !value['secondary']);
    return primaryPokemon;
  }
}
