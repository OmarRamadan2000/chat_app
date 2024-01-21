import 'package:chat_app/core/errors/failure.dart';
import 'package:chat_app/features/login/data/models/user.dart';
import 'package:chat_app/features/login/domain/repositories/auth_repo.dart';
import 'package:chat_app/features/login/domain/use_cases/Base_UseCase.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpUseCase extends BaseUseCase<UserCredential, UserModel> {
  final AuthRepo _authRepo;

  SignUpUseCase(this._authRepo);

  @override
  Future<Either<Failure, UserCredential>> call([UserModel? param]) async {
    return await _authRepo.signUpWithEmailRepo(param!);
  }
}
