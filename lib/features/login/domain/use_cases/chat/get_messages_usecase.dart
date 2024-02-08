import 'package:chat_app/features/login/data/models/message_model.dart';
import 'package:chat_app/features/login/domain/repositories/chat_repo.dart';

class GetUMessagesUseCase {
  final ChatRepo chatRepo;

  GetUMessagesUseCase({required this.chatRepo});
  Stream<List<MessageModel>> call([param]) {
    return chatRepo.getMessageRepo(param);
  }
}
