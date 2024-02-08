import 'dart:io';

import 'package:chat_app/core/errors/failure.dart';
import 'package:chat_app/features/login/data/data_sources/settings_remote_data_source.dart';
import 'package:chat_app/features/login/data/models/user.dart';
import 'package:chat_app/features/login/domain/repositories/settings_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SettingsRepoImpl extends SettingsRepo {
  final SettingsRemoteDataSourceImpl settingsRemote;

  SettingsRepoImpl({required this.settingsRemote});

  @override
  Future<Either<Failure, String>> uploadImageRepo(File param) async {
    final result = await settingsRemote.uploadImage(param);
    try {
      return Right(result);
    } on FirebaseException catch (failure) {
      return Left(Failure(failure.code));
    }
  }

  @override
  Future<Either<Failure, void>> updateProfileRepo(UserModel param) async {
    final result = await settingsRemote.updateProfile(param);
    try {
      return Right(result);
    } on FirebaseException catch (failure) {
      return Left(Failure(failure.code));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserRepo() async {
    final result = await settingsRemote.getUser();
    try {
      return Right(result);
    } on FirebaseException catch (failure) {
      return Left(Failure(failure.code));
    }
  }
}
