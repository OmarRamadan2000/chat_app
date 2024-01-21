import 'package:chat_app/features/login/data/data_sources/auth_remote_data_source.dart';
import 'package:chat_app/features/login/data/data_sources/chat_remote_data_source.dart';
import 'package:chat_app/features/login/data/repositories_impl/auth_repo_impl.dart';
import 'package:chat_app/features/login/data/repositories_impl/caht_repo_impl.dart';
import 'package:chat_app/features/login/domain/repositories/auth_repo.dart';
import 'package:chat_app/features/login/domain/repositories/chat_repo.dart';
import 'package:chat_app/features/login/domain/use_cases/Auth/create_user_usecase.dart';
import 'package:chat_app/features/login/domain/use_cases/Auth/signIn_usecase.dart';
import 'package:chat_app/features/login/domain/use_cases/Auth/signUp_usecase.dart';
import 'package:chat_app/features/login/domain/use_cases/chat/get_usersUseCase.dart';
import 'package:chat_app/features/login/domain/use_cases/chat/send_message_use_case.dart';
import 'package:chat_app/features/login/presentation/blocs/Auth%20cubit/cubit/auth_cubit.dart';
import 'package:chat_app/features/login/presentation/blocs/Chat%20cubit/cubit/chat_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///cubit
  sl.registerFactory(() => AuthCubit(sl(), sl(), sl()));
  sl.registerFactory(() => ChatCubit(sl(), sl()));

  ///use case
  /////////auth
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => CreateUserUseCase(sl()));
  ////////chat
  sl.registerLazySingleton(() => GetUserUseCase(chatRepo: sl()));
  sl.registerLazySingleton(() => SendMessageUseCase(sl()));

  ///repository
  ///////authRepo
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(authRemote: sl()));
  ///////chatRepo
  sl.registerLazySingleton<ChatRepo>(() => ChatRepoImpl(chatRemote: sl()));

  /// remote data source
  /////// Auth remote data source
  sl.registerLazySingleton(
    () => AuthRemoteDataSourceImpl(
      auth: sl(),
      firestore: sl(),
    ),
  );
  ///////Chat remote data source
  sl.registerLazySingleton(
    () => ChatRemoteDataSourceImpl(
      firestore: sl(),
    ),
  );

  //External

  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
