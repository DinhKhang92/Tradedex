import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:tradedex/pages/contacts/cubit/contacts_cubit.dart';
import 'package:tradedex/pages/contacts/cubit/trading_code_cubit.dart';

import 'package:firebase_database/firebase_database.dart';

class AddContactDialog extends StatefulWidget {
  @override
  _AddContactDialogState createState() => _AddContactDialogState();
}

class _AddContactDialogState extends State<AddContactDialog> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      contentPadding: const EdgeInsets.all(18.0),
      content: Row(
        children: [
          Form(
            child: Expanded(
              child: Form(
                key: this._formKey,
                child: TextFormField(
                  style: TextStyle(color: textColor),
                  validator: (id) => BlocProvider.of<TradingCodeCubit>(context).validateTradingCode(id),
                  onChanged: (id) => BlocProvider.of<ContactsCubit>(context).setIdInput(id),
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
                ),
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
                if (this._formKey.currentState.validate()) print("validate: true");
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
}
