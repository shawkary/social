import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/modules/Social_App/login_screen/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super(SocialInitialLoginState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  bool obsecureText = true;

  void changeEyePassword()
  {
    obsecureText = !obsecureText;
    emit(SocialSecurePasswordState());
  }

  void postLoginData({
    required userEmail,
    required userPassword,
  }) {
    emit(SocialLoadingLoginState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    ).then((value) {
      print(value.user?.email);
      emit(SocialSuccessLoginState(uid: value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(SocialErrorLoginState());
    });
  }
}