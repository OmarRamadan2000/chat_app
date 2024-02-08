import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/utils/Funcations/vaildtor.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/features/login/data/models/user.dart';
import 'package:chat_app/features/login/presentation/blocs/settings%20cubit/cubit/settings_cubit.dart';
import 'package:chat_app/features/login/presentation/widgets/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var emailController = TextEditingController();
var nameEnController = TextEditingController();
var phoneController = TextEditingController();
final GlobalKey<FormState> formkey = GlobalKey<FormState>();

class EditProfile extends StatelessWidget {
  const EditProfile({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    emailController.text = user.email!;
    nameEnController.text = user.name!;
    phoneController.text = user.phone!;
    bool loading = false;
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<SettingsCubit>(context).imagefile = null;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Text(
                'Profile',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 15),
              child: InkWell(
                onTap: () {
                  BlocProvider.of<SettingsCubit>(context).imagefile = null;
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black)),
                  child: const Center(child: Text('close')),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocConsumer<SettingsCubit, SettingsState>(
                listener: (context, state) {
                  if (state is UpdateProfileLoding ||
                      state is UploadImageLoding ||
                      state is GetUserLoding) {
                    loading = true;
                  } else {
                    loading = false;
                  }
                },
                builder: (context, state) {
                  File? profileImage =
                      BlocProvider.of<SettingsCubit>(context).imagefile;
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                              child: ClipOval(
                                  child: profileImage != null
                                      ? Image.file(profileImage,
                                          fit: BoxFit.cover)
                                      : CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: user.profileImage!,
                                          placeholder: (context, url) =>
                                              const ShimmerImage(size: 55),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        )),
                            )),
                        TextButton(
                            onPressed: () {
                              BlocProvider.of<SettingsCubit>(context)
                                  .pickImage();
                            },
                            child: const Text('Change profile picture')),

                        const RowBeforeTextField(label: 'Full name'),

                        defualtTextFormField(
                          controller: nameEnController,
                          type: TextInputType.name,
                          hint: 'Name',
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
                        const RowBeforeTextField(label: 'Email'),

                        defualtTextFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          hint: 'user name or email',
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

                        //////////////////////////////////////////////////////////////
                        const RowBeforeTextField(label: 'Phone number'),

                        defualtTextFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          hint: 'phone',
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
                          height: 40,
                        ),
                        defualtButton(
                            text: 'Save changes',
                            loading: loading,
                            function: () async {
                              if (validateAndSave(formkey)) {
                                BlocProvider.of<SettingsCubit>(context)
                                    .updateProfile(
                                        nameEnController.text,
                                        emailController.text,
                                        phoneController.text,
                                        user.profileImage!);
                              }
                            }),
                      ]);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
