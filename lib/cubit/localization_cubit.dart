import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'dart:io';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  static String languageCode = Platform.localeName.split('_').first;
  static String countryCode = Platform.localeName.split('_').last;
  LocalizationCubit() : super(LocalizationState(locale: Locale(languageCode, countryCode)));

  void setLocale(Locale newLocale) => emit(LocalizationState(locale: newLocale));

  void dispose() {
    this.close();
  }
}
