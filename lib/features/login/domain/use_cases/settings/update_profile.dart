import 'package:chat_app/core/errors/failure.dart';
import 'package:chat_app/features/login/data/models/user.dart';
import 'package:chat_app/features/login/domain/repositories/settings_repo.dart';
import 'package:chat_app/features/login/domain/use_cases/Base_UseCase.dart';
import 'package:dartz/dartz.dart';

class UpdateProfileUseCase extends BaseUseCase<void, UserModel> {
  final SettingsRepo settingsRepo;

  UpdateProfileUseCase(this.settingsRepo);

  @override
  Future<Either<Failure, void>> call([UserModel? param]) async {
    return await settingsRepo.updateProfileRepo(param!);
  }
}
