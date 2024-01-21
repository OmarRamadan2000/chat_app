import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:meta/meta.dart';

part 'manage_password_state.dart';

class ManagePasswordCubit extends Cubit<ManagePasswordState> {
  ManagePasswordCubit() : super(ManagePasswordInitial());
  /////////////////////////////////////////////////////////////
  Icon suffixPasswordSignin = const Icon(Ionicons.eye_off_outline);
  Icon suffixPasswordSignUp1 = const Icon(Ionicons.eye_off_outline);
  Icon suffixPasswordSignUp2 = const Icon(Ionicons.eye_off_outline);
  bool visiablePassword = true;
  bool visiablePassword1 = true;
  bool visiablePassword2 = true;

  void changeVisiabilitySignIn() {
    suffixPasswordSignin = visiablePassword
        ? const Icon(Ionicons.eye_outline)
        : const Icon(Ionicons.eye_off_outline);
    visiablePassword = !visiablePassword;
    emit(ChangeVisiablePasswordStates());
  }

  void changeVisiabilitySignUp1() {
    suffixPasswordSignUp1 = visiablePassword1
        ? const Icon(Ionicons.eye_outline)
        : const Icon(Ionicons.eye_off_outline);
    visiablePassword1 = !visiablePassword1;
    emit(ChangeVisiablePasswordStates());
  }

  void changeVisiabilitySignUp2() {
    suffixPasswordSignUp2 = visiablePassword2
        ? const Icon(Ionicons.eye_outline)
        : const Icon(Ionicons.eye_off_outline);
    visiablePassword2 = !visiablePassword2;
    emit(ChangeVisiablePasswordStates());
  }

  /////////////////////////////////////////////////////////////////
}
