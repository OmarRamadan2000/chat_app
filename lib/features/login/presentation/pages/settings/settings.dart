import 'package:chat_app/core/cache_helper/cache_helper.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/features/login/presentation/pages/Auth/login.dart';
import 'package:chat_app/features/login/presentation/pages/settings/edit_profile.dart';
import 'package:chat_app/features/login/presentation/widgets/component.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [BoxShadow(blurRadius: 5, color: AppColors.grey2)],
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ImageAvatar(size: 32),
                          const SizedBox(
                            width: 12,
                          ),
                          const Name(name: 'omar'),
                          Container(
                            alignment: AlignmentDirectional.center,
                            child: IconButton(
                                onPressed: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,

                                    screen: const EditProfile(),
                                    withNavBar:
                                        false, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                                icon: const Icon(
                                  Icons.chevron_right_sharp,
                                )),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
                height: 320,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [BoxShadow(blurRadius: 5, color: AppColors.grey2)],
                  color: Colors.white,
                ),
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => SizedBox(
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(children: [
                              Text(
                                AppStrings.settings[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Colors.black),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.chevron_right_sharp,
                                  )),
                            ]),
                          ),
                        ),
                    separatorBuilder: (context, index) =>
                        Container(height: 1, color: Colors.grey),
                    itemCount: AppStrings.settings.length)),
            const SizedBox(
              height: 30,
            ),
            defualtButton(
                text: 'Sign Out',
                function: () {
                  CacheHelper.removeData(key: 'uId');
                  navigateAndFinish(context, const Login());

                  //navigateAndFinishNavBar(context, const Login());
                })
          ],
        ),
      )),
    );
  }
}
