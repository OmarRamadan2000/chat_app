import 'dart:async';

import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/features/login/data/models/message_model.dart';
import 'package:chat_app/features/login/data/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatRemoteDataSource {
  Future<List<UserModel>> getUsers();
  Future<void> sendMessage(MessageModel message);
  Stream<List<MessageModel>> getMessages(String param);
}

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  final FirebaseFirestore firestore;

  ChatRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<UserModel>> getUsers() async {
    var data = await firestore.collection('users').get();
    List<UserModel> listUsers = [];

    for (var result in data.docs) {
      if (AppStrings.uId != result.data()['uId']) {
        listUsers.add(UserModel.fromJson(result.data()));
      }
    }
    return listUsers;
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    // set my chats
    await FirebaseFirestore.instance
        .collection('users')
        .doc(message.senderId)
        .collection('chats')
        .doc(message.receiverId)
        .collection('messages')
        .add(message.toJson());

    // set receiver chats
    await FirebaseFirestore.instance
        .collection('users')
        .doc(message.receiverId)
        .collection('chats')
        .doc(message.senderId)
        .collection('messages')
        .add(message.toJson());
  }

  @override
  Stream<List<MessageModel>> getMessages(String param) {
    // TODO: implement getMessages
    throw UnimplementedError();
  }
}
