part of 'trading_code_cubit.dart';

@immutable
abstract class TradingCodeState {
  final bool valid;
  TradingCodeState({this.valid});
}

class TradingCodeInitial extends TradingCodeState {
  final bool valid;
  TradingCodeInitial({@required this.valid});
}

class TradingCodeLoading extends TradingCodeState {
  final bool valid;
  TradingCodeLoading({@required this.valid});
}

class TradingCodeLoaded extends TradingCodeState {
  final bool valid;
  TradingCodeLoaded({@required this.valid});
}

class TradingCodeError extends TradingCodeState {}
