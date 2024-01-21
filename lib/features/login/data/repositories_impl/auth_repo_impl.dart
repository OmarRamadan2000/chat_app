import 'package:chat_app/core/errors/failure.dart';
import 'package:chat_app/features/login/data/data_sources/auth_remote_data_source.dart';
import 'package:chat_app/features/login/data/models/user.dart';
import 'package:chat_app/features/login/domain/entities/sign_in_entity.dart';
import 'package:chat_app/features/login/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthRemoteDataSourceImpl authRemote;

  AuthRepoImpl({required this.authRemote});
  @override
  Future<Either<Failure, UserCredential>> signInWithEmailRepo(
      SignInWithEmailEntity param) async {
    final result = await authRemote.signIn(param);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(Failure(failure.code));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signUpWithEmailRepo(
      UserModel param) async {
    final result = await authRemote.signUp(param);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(Failure(failure.code));
    }
  }

  @override
  Future<Either<Failure, void>> createUserRepo(UserModel param) async {
    final result = await authRemote.createUser(param);

    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      if (kDebugMode) {
        print(failure.code);
      }
      return Left(Failure(failure.code));
    }
  }
}
