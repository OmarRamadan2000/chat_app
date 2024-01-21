import 'package:chat_app/core/errors/failure.dart';
import 'package:chat_app/features/login/data/models/user.dart';
import 'package:chat_app/features/login/domain/repositories/auth_repo.dart';
import 'package:chat_app/features/login/domain/use_cases/Base_UseCase.dart';
import 'package:dartz/dartz.dart';

class CreateUserUseCase extends BaseUseCase<void, UserModel> {
  final AuthRepo authRepo;

  CreateUserUseCase(this.authRepo);

  @override
  Future<Either<Failure, void>> call([UserModel? param]) async {
    return await authRepo.createUserRepo(param!);
  }
}
