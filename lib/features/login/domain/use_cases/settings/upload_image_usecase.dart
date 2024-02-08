import 'dart:io';

import 'package:chat_app/core/errors/failure.dart';
import 'package:chat_app/features/login/domain/repositories/settings_repo.dart';
import 'package:chat_app/features/login/domain/use_cases/Base_UseCase.dart';
import 'package:dartz/dartz.dart';

class UploadImageUseCase extends BaseUseCase<String, File> {
  final SettingsRepo settingsRepo;

  UploadImageUseCase({required this.settingsRepo});
  @override
  Future<Either<Failure, String>> call([param]) async {
    return await settingsRepo.uploadImageRepo(param!);
  }
}
