part of 'manage_password_cubit.dart';

@immutable
sealed class ManagePasswordState {}

final class ManagePasswordInitial extends ManagePasswordState {}

class ChangeVisiablePasswordStates extends ManagePasswordState {
  ChangeVisiablePasswordStates();
}
