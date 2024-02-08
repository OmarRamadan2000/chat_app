import 'package:chat_app/features/login/data/data_sources/auth_remote_data_source.dart';
import 'package:chat_app/features/login/data/data_sources/chat_remote_data_source.dart';
import 'package:chat_app/features/login/data/data_sources/settings_remote_data_source.dart';
import 'package:chat_app/features/login/data/repositories_impl/auth_repo_impl.dart';
import 'package:chat_app/features/login/data/repositories_impl/chat_repo_impl.dart';
import 'package:chat_app/features/login/domain/repositories/auth_repo.dart';
import 'package:chat_app/features/login/domain/repositories/chat_repo.dart';
import 'package:chat_app/features/login/domain/repositories/settings_repo.dart';
import 'package:chat_app/features/login/domain/use_cases/Auth/create_user_usecase.dart';
import 'package:chat_app/features/login/domain/use_cases/Auth/signIn_usecase.dart';
import 'package:chat_app/features/login/domain/use_cases/Auth/signUp_usecase.dart';
import 'package:chat_app/features/login/domain/use_cases/chat/get_messages_usecase.dart';
import 'package:chat_app/features/login/domain/use_cases/chat/get_usersUseCase.dart';
import 'package:chat_app/features/login/domain/use_cases/chat/send_message_use_case.dart';
import 'package:chat_app/features/login/domain/use_cases/settings/get_user_usecase.dart';
import 'package:chat_app/features/login/domain/use_cases/settings/update_profile.dart';
import 'package:chat_app/features/login/domain/use_cases/settings/upload_image_usecase.dart';
import 'package:chat_app/features/login/presentation/blocs/Auth%20cubit/cubit/auth_cubit.dart';
import 'package:chat_app/features/login/presentation/blocs/Chat%20cubit/cubit/chat_cubit.dart';
import 'package:chat_app/features/login/presentation/blocs/settings%20cubit/cubit/settings_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

import '../../../features/login/data/repositories_impl/settings_repo_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///cubit

  sl.registerFactory(() => AuthCubit(sl(), sl(), sl()));
  sl.registerFactory(() => ChatCubit(sl(), sl()));
  sl.registerFactory(() => SettingsCubit(sl(), sl(), sl()));

  ///use case
  /////////auth
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => CreateUserUseCase(sl()));
  ////////settings
  sl.registerLazySingleton(() => UploadImageUseCase(settingsRepo: sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
  sl.registerLazySingleton(() => GetUserUseCase(sl()));
  ////////chat
  sl.registerLazySingleton(() => GetUsersUseCase(chatRepo: sl()));
  sl.registerLazySingleton(() => SendMessageUseCase(sl()));
  sl.registerLazySingleton(() => GetUMessagesUseCase(chatRepo: sl()));

  ///repository
  ///////authRepo
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(authRemote: sl()));
  ///////chatRepo
  sl.registerLazySingleton<ChatRepo>(() => ChatRepoImpl(chatRemote: sl()));
  /////////settings
  sl.registerLazySingleton<SettingsRepo>(
      () => SettingsRepoImpl(settingsRemote: sl()));

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
  //////// settings remote
  sl.registerLazySingleton(
    () => SettingsRemoteDataSourceImpl(sl(), sl()),
  );
  //External

  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
}
