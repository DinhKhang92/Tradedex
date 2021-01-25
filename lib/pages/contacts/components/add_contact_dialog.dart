import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:tradedex/pages/contacts/cubit/contacts_cubit.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'dart:async';

class AddContactDialog extends StatefulWidget {
  @override
  _AddContactDialogState createState() => _AddContactDialogState();
}

class _AddContactDialogState extends State<AddContactDialog> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String inputId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      contentPadding: const EdgeInsets.all(18.0),
      content: Row(
        children: [
          Form(
            key: this._formKey,
            child: Container(
              width: MediaQuery.of(context).size.width - 166,
              child: BlocBuilder<ContactsCubit, ContactsState>(
                builder: (context, state) {
                  return TextFormField(
                    style: TextStyle(color: textColor),
                    validator: (id) => _validateTradingCode(id, state),
                    onChanged: (id) => this.inputId = id,
                    autofocus: true,
                    cursorColor: buttonColor,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: textColor),
                      ),
                      labelText: AppLocalizations.of(context).translate('PAGE_CONTACTS.DIALOG_ADD.TITLE'),
                      labelStyle: TextStyle(color: textColor),
                      hintText: '-LVePy20jxxxxxxxxxxx',
                      hintStyle: TextStyle(color: prefillTextColor),
                    ),
                  );
                },
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: buttonColor,
            child: IconButton(
              icon: Icon(
                Icons.send,
                color: buttonTextColor,
              ),
              color: iconColor,
              onPressed: () {
                if (this._formKey.currentState.validate()) BlocProvider.of<ContactsCubit>(context).addContact(this.inputId);
                // BlocProvider.of<ContactsCubit>(context).addContact();
                // validateInputs();
                // if (this.validId != null) {
                //   addContact();
                //   this.validId = null;
                //   Navigator.pop(context);
                // }
              },
            ),
          ),
        ],
      ),
    );
  }

  String _validateTradingCode(String id, ContactsState state) {
    print(state.contacts.keys.contains(id));
    if (id.length != 20)
      return AppLocalizations.of(context).translate('PAGE_CONTACTS.INVALID_CODE');
    else if (id[0] != '-')
      return AppLocalizations.of(context).translate('PAGE_CONTACTS.INVALID_CODE');
    else if (state.contacts.keys.contains(id))
      return AppLocalizations.of(context).translate('PAGE_CONTACTS.INVALID_CODE_IN_LIST');
    else
      return null;
  }
}
