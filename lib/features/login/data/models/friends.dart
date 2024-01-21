class FriendsModel {
  String? uId;
  String? name;
  bool? status = false;
  FriendsModel({required this.uId, required this.name, this.status});
  factory FriendsModel.fromJson(Map<String, dynamic> json) => FriendsModel(
        uId: json['uId'] as String?,
        name: json['name'] as String?,
        status: json['state'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'uId': uId,
        'name': name,
        'state': status,
      };
}
