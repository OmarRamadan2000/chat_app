import 'package:chat_app/core/errors/failure.dart';
import 'package:chat_app/features/login/data/models/user.dart';
import 'package:chat_app/features/login/domain/entities/sign_in_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserCredential>> signInWithEmailRepo(
      SignInWithEmailEntity param);
  Future<Either<Failure, UserCredential>> signUpWithEmailRepo(UserModel param);
  Future<Either<Failure, void>> createUserRepo(UserModel param);
}
