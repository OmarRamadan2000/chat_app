import 'package:chat_app/core/errors/failure.dart';
import 'package:chat_app/features/login/data/data_sources/chat_remote_data_source.dart';
import 'package:chat_app/features/login/data/models/message_model.dart';
import 'package:chat_app/features/login/data/models/user.dart';
import 'package:chat_app/features/login/domain/repositories/chat_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRepoImpl extends ChatRepo {
  final ChatRemoteDataSourceImpl chatRemote;

  ChatRepoImpl({required this.chatRemote});

  @override
  Future<Either<Failure, List<UserModel>>> getUserRepo() async {
    final result = await chatRemote.getUsers();
    try {
      return Right(result);
    } on FirebaseException catch (failure) {
      return Left(Failure(failure.code));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessageRepo(MessageModel param) async {
    final result = await chatRemote.sendMessage(param);
    try {
      return Right(result);
    } on FirebaseException catch (failure) {
      return Left(Failure(failure.code));
    }
  }

  @override
  Stream<Either<Failure, List<MessageModel>>> getMessageRepo() {
    // TODO: implement getMessageRepo
    throw UnimplementedError();
  }
}
