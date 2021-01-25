part of 'signin_cubit.dart';

@immutable
abstract class SigninState {}

class SigninInitial extends SigninState {}

class SigninLoading extends SigninState {}

class SigninLoaded extends SigninState {}

class SigninError extends SigninState {}
