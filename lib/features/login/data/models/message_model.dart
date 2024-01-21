class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;

  MessageModel({this.senderId, this.receiverId, this.dateTime, this.text});

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        senderId: json['senderId'] as String?,
        receiverId: json['receiverId'] as String?,
        dateTime: json['dateTime'] as String?,
        text: json['text'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'senderId': senderId,
        'receiverId': receiverId,
        'dateTime': dateTime,
        'text': text,
      };
}
