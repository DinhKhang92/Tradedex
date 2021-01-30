import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState(isDarkTheme: false));

  void toggleTheme() => emit(SettingsState(isDarkTheme: !state.isDarkTheme));

  void dispose() {
    this.close();
  }
}
