import 'package:chat_app/features/login/data/models/user.dart';
import 'package:chat_app/features/login/presentation/blocs/Chat%20cubit/cubit/chat_cubit.dart';
import 'package:chat_app/features/login/presentation/blocs/settings%20cubit/cubit/settings_cubit.dart';
import 'package:chat_app/features/login/presentation/pages/users.dart';
import 'package:chat_app/features/login/presentation/pages/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

// ignore: must_be_immutable
class BottomBar extends StatelessWidget {
  BottomBar({super.key});

  late PersistentTabController controler;
  late List<UserModel> users;
  @override
  Widget build(BuildContext context) {
    controler = PersistentTabController(initialIndex: 0);
    return Scaffold(
        body: PersistentTabView(
      onItemSelected: (value) {
        if (value == 0) {
          BlocProvider.of<ChatCubit>(context).getUsers();
        }
        if (value == 1) {
          BlocProvider.of<SettingsCubit>(context).getUser();
        }
      },
      hideNavigationBar: false,
      context,
      controller: controler,
      screens: _buildScreens(),
      items: navBarItems(),

      confineInSafeArea: true,
      backgroundColor: Colors.grey.shade50, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      navBarStyle: NavBarStyle.style14,
    ));
  }

  List<Widget> _buildScreens() {
    return [const Users(), const Settings()];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      // PersistentBottomNavBarItem(
      //   icon: const Icon(Icons.home),
      //   activeColorPrimary: Colors.black,
      // ),
      PersistentBottomNavBarItem(
        icon: const Icon(Ionicons.people_circle_outline),
        activeColorPrimary: Colors.black,
      ),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(Ionicons.chatbubble_sharp),
      //   activeColorPrimary: Colors.black,
      // ),
      PersistentBottomNavBarItem(
        icon: const Icon(Ionicons.options_outline),
        activeColorPrimary: Colors.black,
      ),
    ];
  }
}
