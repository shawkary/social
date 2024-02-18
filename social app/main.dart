import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layout/social_app/cubit/social_cubit.dart';
import 'package:flutter_project/layout/social_app/social_layout.dart';
import 'package:flutter_project/shared/components/constants.dart';
import 'package:flutter_project/shared/network/local/cache_helper.dart';
import 'package:flutter_project/shared/network/remote/dio_helper.dart';
import 'package:flutter_project/shared/styles/themes.dart';
import 'modules/Social_App/login_screen/social_login_screen.dart';
import 'modules/Social_App/register_screen/social_register_screen.dart';
import 'modules/users/users_screen.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: "AIzaSyBkLVWEx7zzRL-iFpvpqIfLyX-i0_TmNx8",
      appId: "1:768565283830:android:56532a7aeeccfe99fc95d7",
      messagingSenderId: "768565283830",
      projectId: "shawkary-app",
      storageBucket: "gs://shawkary-app.appspot.com",
    )
  );
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  Widget widget;

  uid = CacheHelper.getData(key: 'uid');

  if(uid != null){
    widget = SocialLayout();
  }else{
    widget = SocialLoginScreen();
  }

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubit>(
            create: (BuildContext context) => SearchCubit(),
        ),
        BlocProvider<SocialCubit>(
            create: (BuildContext context) => SocialCubit()..getUserData()..getPosts(),
        )
      ],
      child: MyApp(widget)));
}

class MyApp extends StatelessWidget {
  final widget;
  MyApp(this.widget);


  @override
  Widget build(BuildContext context) {
        return MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: widget,
        );
  }
}
