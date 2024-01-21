import 'package:chat_app/core/errors/failure.dart';
import 'package:chat_app/features/login/data/models/message_model.dart';
import 'package:chat_app/features/login/domain/repositories/chat_repo.dart';
import 'package:chat_app/features/login/domain/use_cases/Base_UseCase.dart';
import 'package:dartz/dartz.dart';

class SendMessageUseCase extends BaseUseCase<void, MessageModel> {
  final ChatRepo chatRepo;

  SendMessageUseCase(this.chatRepo);

  @override
  Future<Either<Failure, void>> call([MessageModel? param]) async {
    return await chatRepo.sendMessageRepo(param!);
  }
}
