import 'package:flutter/material.dart';

bool validateAndSave(GlobalKey<FormState> formkey) {
  final FormState? form = formkey.currentState;
  if (form!.validate()) {
    print('Form is valid');
    return true;
  } else {
    print('Form is invalid');
    return false;
  }
}
