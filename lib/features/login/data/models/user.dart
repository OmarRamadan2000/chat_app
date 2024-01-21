class UserModel {
  String? email;
  String? phone;
  String? name;
  String? password;
  String? uId;
  String? profileImage;
  List<String>? friends;

  UserModel(
      {this.email,
      this.phone,
      this.name,
      this.uId,
      this.password,
      this.friends,
      this.profileImage});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        name: json['name'] as String?,
        uId: json['uId'] as String?,
        profileImage: json['profileImage'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'phone': phone,
        'name': name,
        'uId': uId,
        'profileImage': profileImage
      };
}
