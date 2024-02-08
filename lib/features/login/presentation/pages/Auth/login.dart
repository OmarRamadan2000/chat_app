import 'package:chat_app/core/utils/Funcations/vaildtor.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/features/login/presentation/blocs/Auth%20cubit/cubit/auth_cubit.dart';
import 'package:chat_app/features/login/presentation/blocs/cubit/manage_password_cubit.dart';
import 'package:chat_app/features/login/presentation/pages/Auth/sign_up.dart';
import 'package:chat_app/features/login/presentation/pages/bottom_bar.dart';
import 'package:chat_app/features/login/presentation/widgets/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var emailController = TextEditingController();
var passwordController = TextEditingController();
final GlobalKey<FormState> formkey = GlobalKey<FormState>();

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    bool loading = false;
    var manageCubit = BlocProvider.of<ManagePasswordCubit>(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (BuildContext context) {
                return BottomBar();
              },
            ),
            (_) => false,
          );
        }
        if (state is SignInLoding) {
          loading = true;
        } else {
          loading = false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      "Log in",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const Text(
                      'sign in to start chatting with frindes',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const RowBeforeTextField(label: 'enter your email'),

                    defualtTextFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      hint: 'user name or email',
                      suffix: const Icon(Icons.person_outline_sharp),
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Email must not be embty";
                        }

                        if (!RegExp(AppStrings.regexpEmail).hasMatch(value)) {
                          return "enter valid email";
                        }

                        return null;
                      },
                    ),
                    /////////////////////////////////////////////////////////////////////////
                    const RowBeforeTextField(label: 'enter your password'),

                    defualtTextFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      hint: '*********************',
                      suffix: IconButton(
                          onPressed: () {
                            manageCubit.changeVisiabilitySignIn();
                          },
                          icon: manageCubit.suffixPasswordSignin),
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Password must not be embty";
                        }

                        if (!RegExp(AppStrings.regexpPass).hasMatch(value)) {
                          return "enter valid Password";
                        }

                        return null;
                      },
                    ),
                    //////////////////////////////////////////////////////////

                    const SizedBox(
                      height: 20,
                    ),
                    defualtButton(
                        text: 'Sign in',
                        loading: loading,
                        function: () async {
                          if (validateAndSave(formkey)) {
                            await BlocProvider.of<AuthCubit>(context)
                                .signInValidate(emailController.text,
                                    passwordController.text);
                          }
                        }),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account? '),
                        TextButton(
                            onPressed: () {
                              navigateTo(context, const SignUp());
                            },
                            child: const Text('sign up')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
