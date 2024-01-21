import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chat_app/core/cache_helper/cache_helper.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/features/login/presentation/pages/Auth/login.dart';
import 'package:chat_app/features/login/presentation/pages/bottom_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var uId = CacheHelper.getData(key: 'uId');
    if (uId != null) {
      AppStrings.uId = uId;
    }

    return AnimatedSplashScreen(
      splash: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/Intro Screen.png',
            ),
          ),
        ],
      ),
      nextScreen: AppStrings.uId == '' ? const Login() : BottomBar(),
      splashIconSize: MediaQuery.of(context).size.height,
      animationDuration: const Duration(seconds: 2),
      centered: false,
    );
  }
}
