import 'package:chat_app/core/errors/failure.dart';
import 'package:chat_app/features/login/data/models/message_model.dart';
import 'package:chat_app/features/login/data/models/user.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepo {
  Future<Either<Failure, List<UserModel>>> getUserRepo();
  Future<Either<Failure, void>> sendMessageRepo(MessageModel param);
  Stream<List<MessageModel>> getMessageRepo(String param);
}
