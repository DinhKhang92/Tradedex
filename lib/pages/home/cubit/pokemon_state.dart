part of 'pokemon_cubit.dart';

@immutable
abstract class PokemonState {
  const PokemonState();
}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final Map pokemon;
  final Map primaryPokemon;
  final Map secondaryPokemon;

  const PokemonLoaded({
    @required this.pokemon,
    @required this.primaryPokemon,
    @required this.secondaryPokemon,
  });
}

class PokemonError extends PokemonState {}
