import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'individual_state.dart';

class IndividualCubit extends Cubit<IndividualState> {
  IndividualCubit() : super(IndividualInitial());
}
