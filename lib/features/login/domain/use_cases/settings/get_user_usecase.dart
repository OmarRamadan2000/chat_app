import 'package:chat_app/core/errors/failure.dart';
import 'package:chat_app/features/login/data/models/user.dart';
import 'package:chat_app/features/login/domain/repositories/settings_repo.dart';
import 'package:chat_app/features/login/domain/use_cases/Base_UseCase.dart';
import 'package:dartz/dartz.dart';

class GetUserUseCase extends BaseUseCase<UserModel, void> {
  final SettingsRepo settingsRepo;

  GetUserUseCase(this.settingsRepo);

  @override
  Future<Either<Failure, UserModel>> call([void param]) async {
    return await settingsRepo.getUserRepo();
  }
}
