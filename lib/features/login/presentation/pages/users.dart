import 'package:chat_app/features/login/data/models/user.dart';
import 'package:chat_app/features/login/presentation/blocs/Chat%20cubit/cubit/chat_cubit.dart';
import 'package:chat_app/features/login/presentation/pages/chat.dart';
import 'package:chat_app/features/login/presentation/widgets/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

List<UserModel> users = [];

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<ChatCubit>(context).getUsers();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: const Icon(Icons.search_rounded),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is GetUsersSuccess) {
            users = state.users;
          }
        },
        builder: (context, state) {
          if (state is GetUsersErorr) {
            return Text(state.errMessage);
          }
          if (state is GetUsersLoding) {
            return const SizedBox(
                height: 1000,
                child: Center(child: CircularProgressIndicator()));
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,

                      screen: Chat(
                        user: users[index],
                      ),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImageAvatar(
                              size: 32, image: users[index].profileImage!),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    users[index].name!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    maxLines: 1,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.start,
                                  //   children: [
                                  //     Expanded(
                                  //       child: SizedBox(
                                  //         height: 20,
                                  //         child: Text(
                                  //           'datdddddddddcccccccccccccdddddsd',
                                  //           style: Theme.of(context)
                                  //               .textTheme
                                  //               .titleSmall,
                                  //           maxLines: 1,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Text(
                                  //       ' . ',
                                  //       style: Theme.of(context)
                                  //           .textTheme
                                  //           .titleSmall,
                                  //     ),
                                  //     Text(
                                  //       '20 jan',
                                  //       style: Theme.of(context)
                                  //           .textTheme
                                  //           .titleSmall,
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
