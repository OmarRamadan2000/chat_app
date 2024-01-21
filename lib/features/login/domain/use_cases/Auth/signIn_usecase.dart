import 'package:chat_app/core/errors/failure.dart';
import 'package:chat_app/features/login/domain/entities/sign_in_entity.dart';
import 'package:chat_app/features/login/domain/repositories/auth_repo.dart';
import 'package:chat_app/features/login/domain/use_cases/Base_UseCase.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInUseCase extends BaseUseCase<UserCredential, SignInWithEmailEntity> {
  final AuthRepo _authRepo;

  SignInUseCase(this._authRepo);

  @override
  Future<Either<Failure, UserCredential>> call(
      [SignInWithEmailEntity? param]) async {
    return await _authRepo.signInWithEmailRepo(param!);
  }
}
