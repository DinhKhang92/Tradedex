part of 'pokemon_cubit.dart';

@immutable
abstract class PokemonState {
  final Map pokemon;
  final Map primaryPokemon;
  final Map secondaryPokemon;
  final String gen;

  const PokemonState({this.pokemon, this.primaryPokemon, this.secondaryPokemon, this.gen});
}

class PokemonInitial extends PokemonState {
  final Map pokemon;
  final Map primaryPokemon;
  final Map secondaryPokemon;
  final String gen;

  PokemonInitial({
    @required this.pokemon,
    @required this.primaryPokemon,
    @required this.secondaryPokemon,
    @required this.gen,
  });
}

class PokemonLoading extends PokemonState {
  final Map pokemon;
  final Map primaryPokemon;
  final Map secondaryPokemon;
  final String gen;

  PokemonLoading({
    @required this.pokemon,
    @required this.primaryPokemon,
    @required this.secondaryPokemon,
    @required this.gen,
  });
}

class PokemonLoaded extends PokemonState {
  final Map pokemon;
  final Map primaryPokemon;
  final Map secondaryPokemon;
  final String gen;

  const PokemonLoaded({
    @required this.pokemon,
    @required this.primaryPokemon,
    @required this.secondaryPokemon,
    @required this.gen,
  });
}

class PokemonError extends PokemonState {
  final Map pokemon;
  final Map primaryPokemon;
  final Map secondaryPokemon;
  final String gen;

  PokemonError({
    @required this.pokemon,
    @required this.primaryPokemon,
    @required this.secondaryPokemon,
    @required this.gen,
  });
}
