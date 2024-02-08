import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app/core/errors/failure.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/features/login/data/models/user.dart';
import 'package:chat_app/features/login/domain/use_cases/settings/get_user_usecase.dart';
import 'package:chat_app/features/login/domain/use_cases/settings/update_profile.dart';
import 'package:chat_app/features/login/domain/use_cases/settings/upload_image_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(
      this.uploadImageUseCase, this.updateProfileUseCase, this.getUserUseCase)
      : super(SettingsInitial());
  File? imagefile;
  final UploadImageUseCase uploadImageUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final GetUserUseCase getUserUseCase;
  String? linkImage;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) return;
    final imageTemporary = File(image.path);
    imagefile = imageTemporary;
    emit(ChangeimageStates());
  }

  Future<void> uploadImage(File param) async {
    emit(UploadImageLoding());
    var result = await uploadImageUseCase.call(param);

    result.fold((failure) {
      emit(UploadImageErorr(errMessage: failure.message));
    }, (link) {
      linkImage = link;
      emit(UploadImageSuccess(linkImage: link));
    });
  }

  void updateProfile(
      String name, String email, String phone, String oldImage) async {
    //String imageLink;
    Either<Failure, void> result;

    UserModel user = UserModel(
        email: email,
        name: name,
        phone: phone,
        profileImage: oldImage,
        uId: AppStrings.uId);
    if (imagefile != null) {
      await uploadImage(imagefile!);

      if (state is UploadImageSuccess) {
        user.profileImage = linkImage;
        emit(UpdateProfileLoding());
        result = await updateProfileUseCase.call(user);
        result.fold((failure) {
          emit(UpdateProfileErorr(errMessage: failure.message));
        }, (link) {
          emit(UpdateProfileSuccess());
        });
      }
    } else {
      emit(UpdateProfileLoding());
      result = await updateProfileUseCase.call(user);
      result.fold((failure) {
        emit(UpdateProfileErorr(errMessage: failure.message));
      }, (link) {
        emit(UpdateProfileSuccess());
      });
    }
    if (state is UpdateProfileSuccess) {
      getUser();
    }
  }

  void getUser() async {
    emit(GetUserLoding());

    var result = await getUserUseCase.call();

    result.fold((failure) {
      emit(GetUserErorr(errMessage: failure.message));
    }, (user) {
      emit(GetUserSuccess(user: user));
    });
  }
}
