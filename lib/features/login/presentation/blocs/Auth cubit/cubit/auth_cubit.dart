import 'package:bloc/bloc.dart';
import 'package:chat_app/core/cache_helper/cache_helper.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/features/login/data/models/user.dart';
import 'package:chat_app/features/login/domain/entities/sign_in_entity.dart';
import 'package:chat_app/features/login/domain/use_cases/Auth/create_user_usecase.dart';
import 'package:chat_app/features/login/domain/use_cases/Auth/signIn_usecase.dart';
import 'package:chat_app/features/login/domain/use_cases/Auth/signUp_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.sigmInUseCase, this.signUpUseCase, this.createUserUseCase)
      : super(AuthInitial(uId: ''));
  final SignInUseCase sigmInUseCase;
  final SignUpUseCase signUpUseCase;
  final CreateUserUseCase createUserUseCase;

  Future<void> signInValidate(String email, String password) async {
    emit(SignInLoding(uId: state.uId));
    var result = await sigmInUseCase
        .call(SignInWithEmailEntity(email: email, password: password));

    result.fold((failure) {
      emit(SignInErorr(errMessage: failure.message, uId: state.uId));
      if (kDebugMode) {
        print(failure.message);
      }
    }, (credential) {
      emit(SignInSuccess(userCredential: credential, uId: state.uId));
      if (kDebugMode) {
        CacheHelper.save_data(key: 'uId', value: credential.user!.uid);
        AppStrings.uId = credential.user!.uid;
        print(credential.toString());
      }
    });
  }

/////////////////////////////////////////////////////////////////////////
  Future<void> signUpValidate(
      String email, String password, String name, String phone) async {
    emit(SignUpLoding(uId: state.uId));
    var result =
        await signUpUseCase.call(UserModel(email: email, password: password));

    result.fold((failure) {
      emit(SignUpErorr(errMessage: failure.message, uId: state.uId));
      if (kDebugMode) {
        print(failure.message);
      }
    }, (credential) async {
      emit(
          SignUpSuccess(userCredential: credential, uId: credential.user!.uid));

      if (kDebugMode) {
        CacheHelper.save_data(key: 'uId', value: credential.user!.uid);
        AppStrings.uId = credential.user!.uid;

        print(credential.toString());
        await createUser(email, name, phone);
      }
    });
  }

///////////////////////////////////////////////////////////////////////////////
  Future<void> createUser(String email, String name, String phone) async {
    emit(CreateUserLoding(uId: state.uId));
    if (kDebugMode) {
      print(state.uId);
    }
    var result = await createUserUseCase.call(UserModel(
        email: email,
        name: name,
        phone: phone,
        uId: state.uId,
        profileImage: AppStrings.userImage));

    result.fold((failure) {
      emit(CreateUserErorr(errMessage: failure.message, uId: state.uId));
      if (kDebugMode) {
        print(failure.message);
      }
    }, (credential) {
      emit(CreateUserSuccess(uId: state.uId));
    });
  }
}
