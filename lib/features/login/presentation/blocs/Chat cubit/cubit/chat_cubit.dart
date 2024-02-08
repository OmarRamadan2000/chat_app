import 'package:bloc/bloc.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/features/login/data/models/message_model.dart';
import 'package:chat_app/features/login/data/models/user.dart';
import 'package:chat_app/features/login/domain/use_cases/chat/get_usersUseCase.dart';
import 'package:chat_app/features/login/domain/use_cases/chat/send_message_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.getUserUseCase, this.sendMessageUseCase)
      : super(ChatInitial());

  final GetUsersUseCase getUserUseCase;
  final SendMessageUseCase sendMessageUseCase;
  // final GetUMessagesUseCase getUMessagesUseCase;
  void getUsers() async {
    emit(GetUsersLoding());
    var result = await getUserUseCase.call();

    result.fold((failure) {
      emit(GetUsersErorr(errMessage: failure.message));
    }, (users) {
      emit(GetUsersSuccess(users: users));
    });
  }

  Future<void> sendMessage(String text, String receiverId) async {
    emit(SendMessageLoding());
    var result = await sendMessageUseCase.call(MessageModel(
        receiverId: receiverId,
        senderId: AppStrings.uId,
        dateTime: DateTime.now().toString(),
        text: text));
    result.fold((failure) {
      emit(SendMessageErorr(errMessage: failure.message));
    }, (users) {
      emit(SendMessageSuccess());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppStrings.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      messages.clear();

      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }

      emit(GetMessagesSuccess());
    });
  }
}
