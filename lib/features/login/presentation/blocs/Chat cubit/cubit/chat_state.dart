part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class GetUsersLoding extends ChatState {}

final class GetUsersErorr extends ChatState {
  final String errMessage;

  GetUsersErorr({required this.errMessage});
}

final class GetUsersSuccess extends ChatState {
  final List<UserModel> users;

  GetUsersSuccess({required this.users});
}

final class SendMessageLoding extends ChatState {}

final class SendMessageErorr extends ChatState {
  final String errMessage;

  SendMessageErorr({required this.errMessage});
}

final class SendMessageSuccess extends ChatState {}

final class GetMessagesSuccess extends ChatState {}
