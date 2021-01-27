part of 'signin_cubit.dart';

@immutable
abstract class SigninState {
  final String tc;
  SigninState({this.tc});
}

class SigninInitial extends SigninState {
  final String tc;
  SigninInitial({@required this.tc});
}

class SigninLoading extends SigninState {
  final String tc;
  SigninLoading({@required this.tc});
}

class SigninLoaded extends SigninState {
  final String tc;
  SigninLoaded({@required this.tc});
}

class SigninError extends SigninState {
  final String tc;
  SigninError({@required this.tc});
}
