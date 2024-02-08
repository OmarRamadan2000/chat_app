import 'dart:io';

import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/features/login/data/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class SettingsRemoteDataSource {
  Future<String> uploadImage(File param);
  Future<void> updateProfile(UserModel param);
  Future<UserModel> getUser();
}

class SettingsRemoteDataSourceImpl extends SettingsRemoteDataSource {
  final FirebaseStorage firestorage;
  final FirebaseFirestore firestore;

  SettingsRemoteDataSourceImpl(this.firestorage, this.firestore);

  @override
  Future<String> uploadImage(File param) async {
    late String link;
    var linkImage = await firestorage
        .ref()
        .child('images/${Uri.file(param.path).pathSegments.last}')
        .putFile(param);
    await linkImage.ref.getDownloadURL().then((value) => link = value);
    return link;
  }

  @override
  Future<void> updateProfile(UserModel param) async {
    await firestore
        .collection('users')
        .doc(AppStrings.uId)
        .update(param.toJson());
  }

  @override
  Future<UserModel> getUser() async {
    UserModel user;
    var result;
    await firestore
        .collection('users')
        .doc(AppStrings.uId)
        .get()
        .then((value) => result = value.data());
    user = UserModel.fromJson(result);
    return user;
  }
}
