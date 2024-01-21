import 'package:chat_app/core/utils/Funcations/vaildtor.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/features/login/presentation/blocs/settings%20cubit/cubit/settings_cubit.dart';
import 'package:chat_app/features/login/presentation/widgets/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var emailController = TextEditingController();
var nameEnController = TextEditingController();
var phoneController = TextEditingController();
final GlobalKey<FormState> formkey = GlobalKey<FormState>();

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onTap: () {},
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
                // TODO: implement listener
              },
              builder: (context, state) {
                var profileImage =
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
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                          backgroundImage: profileImage != null
                              ? FileImage(profileImage)
                              : null,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            BlocProvider.of<SettingsCubit>(context).pickImage();
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

                          if (!RegExp(AppStrings.regexpEmail).hasMatch(value)) {
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

                          if (!RegExp(AppStrings.regexpPhone).hasMatch(value)) {
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
                          function: () async {
                            if (validateAndSave(formkey)) {}
                          }),
                    ]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
