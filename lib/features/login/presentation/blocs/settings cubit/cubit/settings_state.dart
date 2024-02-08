part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

class ChangeimageStates extends SettingsState {}

final class UploadImageLoding extends SettingsState {}

final class UploadImageErorr extends SettingsState {
  final String errMessage;

  UploadImageErorr({required this.errMessage});
}

final class UploadImageSuccess extends SettingsState {
  final String linkImage;

  UploadImageSuccess({required this.linkImage});
}

final class UpdateProfileLoding extends SettingsState {}

final class UpdateProfileErorr extends SettingsState {
  final String errMessage;

  UpdateProfileErorr({required this.errMessage});
}

final class UpdateProfileSuccess extends SettingsState {}

final class GetUserLoding extends SettingsState {}

final class GetUserErorr extends SettingsState {
  final String errMessage;

  GetUserErorr({required this.errMessage});
}

final class GetUserSuccess extends SettingsState {
  final UserModel user;

  GetUserSuccess({required this.user});
}
