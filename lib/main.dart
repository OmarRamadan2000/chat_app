import 'package:chat_app/core/cache_helper/cache_helper.dart';
import 'package:chat_app/core/themes/app_themes.dart';
import 'package:chat_app/core/utils/blocObserver.dart';
import 'package:chat_app/features/login/presentation/blocs/Auth%20cubit/cubit/auth_cubit.dart';
import 'package:chat_app/features/login/presentation/blocs/Chat%20cubit/cubit/chat_cubit.dart';
import 'package:chat_app/features/login/presentation/blocs/cubit/manage_password_cubit.dart';
import 'package:chat_app/features/login/presentation/blocs/settings%20cubit/cubit/settings_cubit.dart';
import 'package:chat_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'package:chat_app/core/utils/Funcations/locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            return ManagePasswordCubit();
          }),
          BlocProvider(create: (_) {
            return di.sl<SettingsCubit>()..getUser();
          }),
          BlocProvider(create: (_) {
            return di.sl<AuthCubit>();
          }),
          BlocProvider(create: (_) => di.sl<ChatCubit>()..getUsers()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: appTheme(),
          home: const SplashScreen(),
        ));
  }
}
