part of 'official_cubit.dart';

@immutable
abstract class OfficialState {
  final int navIdx;
  final Map pokemon;
  final Map gender;
  OfficialState({this.navIdx, this.pokemon, this.gender});
}

class OfficialInitial extends OfficialState {
  final int navIdx;
  final Map pokemon;
  final Map gender;
  OfficialInitial({
    @required this.navIdx,
    @required this.pokemon,
    @required this.gender,
  });
}

class OfficialLoading extends OfficialState {
  final int navIdx;
  final Map pokemon;
  final Map gender;
  OfficialLoading({
    @required this.navIdx,
    @required this.pokemon,
    @required this.gender,
  });
}

class OfficialLoaded extends OfficialState {
  final int navIdx;
  final Map pokemon;
  final Map gender;
  OfficialLoaded({
    @required this.navIdx,
    @required this.pokemon,
    @required this.gender,
  });
}

class OfficialError extends OfficialState {}
