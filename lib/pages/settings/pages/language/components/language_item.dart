import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/cubit/localization_cubit.dart';

class LanguageItem extends StatefulWidget {
  final String language;
  final String languageAcronym;
  final String icon;
  final Color color;
  final Locale locale;

  LanguageItem({
    @required this.language,
    @required this.languageAcronym,
    @required this.icon,
    @required this.color,
    @required this.locale,
  });

  @override
  State<StatefulWidget> createState() {
    return LanguageItemState(
      language: this.language,
      languageAcronym: this.languageAcronym,
      icon: this.icon,
      color: this.color,
      locale: this.locale,
    );
  }
}

class LanguageItemState extends State<LanguageItem> {
  final String language;
  final String languageAcronym;
  final String icon;
  final Color color;
  final Locale locale;

  LanguageItemState({
    @required this.language,
    @required this.languageAcronym,
    @required this.icon,
    @required this.color,
    @required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _changeLanguage(),
      child: Container(
        decoration: BoxDecoration(
          color: this.color.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            width: 1.5,
            color: Colors.white.withOpacity(0.20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 8, left: 8),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Image(
                  image: AssetImage(this.icon),
                  color: Colors.black.withOpacity(0.35),
                ),
              ),
              Center(
                child: Text(
                  this.languageAcronym,
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
              Text(
                this.language,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeLanguage() {
    BlocProvider.of<LocalizationCubit>(context).setLocale(this.locale);
    Navigator.of(context).pop();
  }
}
