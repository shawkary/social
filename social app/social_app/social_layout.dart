import 'package:buildcondition/buildcondition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layout/social_app/cubit/social_cubit.dart';
import 'package:flutter_project/layout/social_app/cubit/social_states.dart';
import 'package:flutter_project/modules/Social_App/bottomNavBar_screens/home.dart';
import 'package:flutter_project/modules/Social_App/bottomNavBar_screens/chats.dart';
import 'package:flutter_project/modules/Social_App/bottomNavBar_screens/users.dart';
import 'package:flutter_project/modules/Social_App/login_screen/social_login_screen.dart';
import 'package:flutter_project/modules/Social_App/search/search_screen.dart';
import 'package:flutter_project/shared/components/components.dart';
import 'package:flutter_project/shared/network/local/cache_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/Social_App/bottomNavBar_screens/settings.dart';
import '../../modules/Social_App/bottomNavBar_screens/post_screen.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  static final List<Widget> screens = [
    HomeScreen(),
    ChatsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  static final List<String> titles = [
    'Home',
    'Chats',
    'Users',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {
        if(state is SocialNewPostState){
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (BuildContext context, Object? state) {
        SocialCubit cubit = SocialCubit().get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
              IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search)
              ),
            ],
          ),
          body: screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.plus? cubit.currentIndex + 1 : cubit.currentIndex,
              onTap: (index){
                cubit.changeCurrentIndex(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
                BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'Post'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Users'),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
              ]
          ),
        );
      },
    );
  }
}
