import 'package:chat_app/features/login/data/models/user.dart';
import 'package:chat_app/features/login/domain/entities/sign_in_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> signIn(SignInWithEmailEntity param);
  Future<UserCredential> signUp(UserModel param);
  Future<void> createUser(UserModel param);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({required this.auth, required this.firestore});

  @override
  Future<UserCredential> signIn(SignInWithEmailEntity param) async {
    return await auth.signInWithEmailAndPassword(
        email: param.email, password: param.password);
  }

  @override
  Future<UserCredential> signUp(UserModel param) async {
    return auth.createUserWithEmailAndPassword(
        email: param.email!, password: param.password!);
  }

  @override
  Future<void> createUser(UserModel param) async {
    await firestore.collection('users').doc(param.uId!).set(param.toJson());
  }
}
