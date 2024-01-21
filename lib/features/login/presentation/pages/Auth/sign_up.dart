import 'package:chat_app/core/utils/Funcations/vaildtor.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/features/login/presentation/blocs/Auth%20cubit/cubit/auth_cubit.dart';
import 'package:chat_app/features/login/presentation/blocs/cubit/manage_password_cubit.dart';
import 'package:chat_app/features/login/presentation/pages/bottom_bar.dart';
import 'package:chat_app/features/login/presentation/widgets/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var emailController = TextEditingController();
var passwordController = TextEditingController();
var passwordController2 = TextEditingController();
var nameEnController = TextEditingController();
var phoneController = TextEditingController();
final GlobalKey<FormState> formkey = GlobalKey<FormState>();

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var manageCubit = BlocProvider.of<ManagePasswordCubit>(context);
    bool loading = false;
    return BlocConsumer<ManagePasswordCubit, ManagePasswordState>(
      listener: (context, state) {
        if (state is SignUpLoding) {
          loading = true;
        } else {
          loading = false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(
                          builder: (BuildContext context) {
                            return BottomBar();
                          },
                        ),
                        (_) => false,
                      );
                    },
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Sign up",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          const Text(
                            'Create an account to start chatting with frindes',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          const RowBeforeTextField(label: 'enter your name'),

                          defualtTextFormField(
                            controller: nameEnController,
                            type: TextInputType.name,
                            hint: 'Name',
                            suffix: const Icon(Icons.person_outline_sharp),
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Name must not be embty";
                              }

                              if (!RegExp(AppStrings.regexpNameEn)
                                  .hasMatch(value)) {
                                return "enter valid Name";
                              }

                              return null;
                            },
                          ),
                          /////////////////////////////////////////////////////////////////////
                          const RowBeforeTextField(label: 'enter your email'),

                          defualtTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            hint: 'user name or email',
                            suffix: const Icon(Icons.mail_rounded),
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Email must not be embty";
                              }

                              if (!RegExp(AppStrings.regexpEmail)
                                  .hasMatch(value)) {
                                return "enter valid email";
                              }

                              return null;
                            },
                          ),
                          /////////////////////////////////////////////////////////////////////////
                          const RowBeforeTextField(
                              label: 'create your password'),

                          defualtTextFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            hint: '*********************',
                            suffix: IconButton(
                              onPressed: () {
                                manageCubit.changeVisiabilitySignUp1();
                              },
                              icon:
                                  BlocProvider.of<ManagePasswordCubit>(context)
                                      .suffixPasswordSignUp1,
                            ),
                            ispassword:
                                BlocProvider.of<ManagePasswordCubit>(context)
                                    .visiablePassword1,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Password must not be embty";
                              }

                              if (!RegExp(AppStrings.regexpPass)
                                  .hasMatch(value)) {
                                return "enter valid Password";
                              }

                              return null;
                            },
                          ),
                          //////////////////////////////////////////////////////////
                          const RowBeforeTextField(label: 'Repeat password'),

                          defualtTextFormField(
                            controller: passwordController2,
                            type: TextInputType.visiblePassword,
                            hint: '*********************',
                            suffix: IconButton(
                              onPressed: () {
                                manageCubit.changeVisiabilitySignUp2();
                              },
                              icon: manageCubit.suffixPasswordSignUp2,
                            ),
                            ispassword: manageCubit.visiablePassword2,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Password must not be embty";
                              }

                              if (!RegExp(AppStrings.regexpPass)
                                  .hasMatch(value)) {
                                return "enter valid Password";
                              }
                              if (passwordController.text !=
                                  passwordController2.text) {
                                return "Password not match";
                              }

                              return null;
                            },
                          ),
                          //////////////////////////////////////////////////////////////
                          const RowBeforeTextField(label: 'enter your phone'),

                          defualtTextFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            hint: 'phone',
                            suffix: const Icon(Icons.phone_android_rounded),
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "phone must not be embty";
                              }

                              if (!RegExp(AppStrings.regexpPhone)
                                  .hasMatch(value)) {
                                return "enter valid phone";
                              }

                              return null;
                            },
                          ),
                          /////////////////////////////////////////////////////////////////////////

                          const SizedBox(
                            height: 20,
                          ),
                          defualtButton(
                              text: 'Sign up',
                              loading: loading,
                              function: () async {
                                if (validateAndSave(formkey)) {
                                  await BlocProvider.of<AuthCubit>(context)
                                      .signUpValidate(
                                          emailController.text,
                                          passwordController.text,
                                          nameEnController.text,
                                          phoneController.text);
                                }
                              }),
                        ],
                      );
                    },
                  )),
            ),
          ),
        );
      },
    );
  }
}
