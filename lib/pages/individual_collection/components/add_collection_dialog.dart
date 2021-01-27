import 'package:flutter/material.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/pages/individual_collection/cubit/individual_cubit.dart';

class AddCollectionDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddCollectionDialogState();
}

class AddCollectionDialogState extends State<AddCollectionDialog> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Map dropdownMap = new Map();

  @override
  void initState() {
    this._loadContext();
    this._loadDropdownList();
    super.initState();
  }

  void _loadContext() {
    BlocProvider.of<IndividualCubit>(context).loadContext(context);
  }

  void _loadDropdownList() {
    String alolan = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.ALOLAN');
    String event = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.EVENT');
    String galar = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.GALAR');
    String pokedex = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.POKEDEX');
    String purified = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.PURIFIED');
    String regional = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.REGIONAL');
    String shadow = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.SHADOW');
    String spinda = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.SPINDA');
    String unown = AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.LIST_TYPES.UNOWN');

    this.dropdownMap[Individual.Alolan] = alolan;
    this.dropdownMap[Individual.Event] = event;
    this.dropdownMap[Individual.Galar] = galar;
    this.dropdownMap[Individual.Pokedex] = pokedex;
    this.dropdownMap[Individual.Purified] = purified;
    this.dropdownMap[Individual.Regional] = regional;
    this.dropdownMap[Individual.Shadow] = shadow;
    this.dropdownMap[Individual.Spinda] = spinda;
    this.dropdownMap[Individual.Unown] = unown;

    BlocProvider.of<IndividualCubit>(context).loadDropdownList(this.dropdownMap);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: dialogBackgroundColor,
      title: Text(
        AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.DIALOG_ADD.TITLE'),
        style: TextStyle(color: textColor),
      ),
      content: Column(
        children: [
          _buildTypeDropdownElement(),
          ListTile(
            leading: Text(
              AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.DIALOG_ADD.NAME'),
              style: TextStyle(color: textColor),
            ),
            title: Form(
              key: this._formKey,
              child: TextFormField(
                onChanged: (name) => BlocProvider.of<IndividualCubit>(context).setCollectionName(name),
                validator: (value) {
                  if (value.isEmpty)
                    return languageFile['PAGE_CONTACTS']['INVALID_NAME'];
                  else
                    return null;
                },
                style: TextStyle(color: textColor),
                // controller: listNameController,
                cursorColor: buttonColor,
                decoration: InputDecoration.collapsed(
                  hintText: AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.DIALOG_ADD.ENTER_NAME'),
                  hintStyle: TextStyle(fontSize: 14, color: textColor),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        FlatButton(
          child: Text(
            AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.DIALOG_ADD.CLOSE'),
            style: TextStyle(color: buttonColor),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        BlocBuilder<IndividualCubit, IndividualState>(
          builder: (context, state) {
            return FlatButton(
              child: Text(
                AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.DIALOG_ADD.CREATE'),
                style: TextStyle(color: buttonColor),
              ),
              onPressed: () => this._formKey.currentState.validate() ? _createList(state.dropdownValue) : {},
            );
          },
        ),
      ],
    );
  }

  Widget _buildTypeDropdownElement() {
    return ListTile(
      leading: Text(
        AppLocalizations.of(context).translate('PAGE_INDIVIDUAL_COLLECTION.DIALOG_ADD.TYPE'),
        style: TextStyle(color: textColor),
      ),
      title: _buildDialogDropdown(),
    );
  }

  Widget _buildDialogDropdown() {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: dialogBackgroundColor),
      child: DropdownButtonHideUnderline(
        child: BlocBuilder<IndividualCubit, IndividualState>(
          builder: (context, state) {
            return DropdownButton(
              iconEnabledColor: textColor,
              style: TextStyle(color: textColor),
              value: state.dropdownValue,
              items: state.dropdownList,
              onChanged: (type) => BlocProvider.of<IndividualCubit>(context).setDropdownValue(type),
            );
          },
        ),
      ),
    );
  }

  void _createList(String selection) {
    Individual key = this.dropdownMap.keys.firstWhere((element) => this.dropdownMap[element] == selection);
    BlocProvider.of<IndividualCubit>(context).addCollection(key);
    Navigator.of(context).pop();
  }
}
