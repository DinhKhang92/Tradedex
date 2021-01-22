part of 'official_cubit.dart';

@immutable
abstract class OfficialState {
  final int navIdx;
  final Map pokemon;
  OfficialState({this.navIdx, this.pokemon});
}

class OfficialInitial extends OfficialState {
  final int navIdx;
  final Map pokemon;
  OfficialInitial({
    @required this.navIdx,
    @required this.pokemon,
  });
}

class OfficialLoading extends OfficialState {
  final int navIdx;
  final Map pokemon;
  OfficialLoading({
    @required this.navIdx,
    @required this.pokemon,
  });
}

class OfficialLoaded extends OfficialState {
  final int navIdx;
  final Map pokemon;
  OfficialLoaded({
    @required this.navIdx,
    @required this.pokemon,
  });
}

class OfficialError extends OfficialState {}
