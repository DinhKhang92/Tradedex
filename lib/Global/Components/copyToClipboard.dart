import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:tradedex/Global/GlobalConstants.dart';

void copyToClipboard(scaffoldKey, text) {
  ClipboardManager.copyToClipBoard(text).then(
    (result) {
      final snackBar = SnackBar(
        content: Text(languageFile['PAGE_DRAWER']['COPY_TO_CLIPBOARD']),
        duration: Duration(milliseconds: 1200),
      );
      scaffoldKey.currentState.showSnackBar(snackBar);
    },
  );
}
