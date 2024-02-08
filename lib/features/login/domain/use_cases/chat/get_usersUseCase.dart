import 'package:chat_app/core/errors/failure.dart';
import 'package:chat_app/features/login/data/models/user.dart';
import 'package:chat_app/features/login/domain/repositories/chat_repo.dart';
import 'package:chat_app/features/login/domain/use_cases/Base_UseCase.dart';
import 'package:dartz/dartz.dart';

class GetUsersUseCase extends BaseUseCase<List<UserModel>, void> {
  final ChatRepo chatRepo;

  GetUsersUseCase({required this.chatRepo});
  @override
  Future<Either<Failure, List<UserModel>>> call([param]) async {
    return await chatRepo.getUserRepo();
  }
}
