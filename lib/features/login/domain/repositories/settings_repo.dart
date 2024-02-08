import 'dart:io';

import 'package:chat_app/core/errors/failure.dart';
import 'package:chat_app/features/login/data/models/user.dart';
import 'package:dartz/dartz.dart';

abstract class SettingsRepo {
  Future<Either<Failure, String>> uploadImageRepo(File param);
  Future<Either<Failure, void>> updateProfileRepo(UserModel param);
  Future<Either<Failure, UserModel>> getUserRepo();
}
