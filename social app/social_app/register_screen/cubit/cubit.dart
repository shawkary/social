import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/models/social_app_model/social_user_model.dart';
import 'package:flutter_project/modules/Social_App/register_screen/cubit/states.dart';

import '../../../../shared/components/constants.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialInitialRegisterState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  bool isSecret = true;

  void changeIconPassword() {
    isSecret = !isSecret;
    emit(SocialChangeIconRegisterState());
  }

////////////////////////////////////////////////////////////////

  void postRegisterData({
    required userEmail,
    required userPassword,
    required userName,
    required userPhone,
  }) {
    emit(SocialLoadingRegisterState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    )
        .then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      userCreate(
        userName: userName,
        userEmail: userEmail,
        userPhone: userPhone,
        uid: value.user?.uid,
      );
    }).catchError((error) {
      print(error.toString());
      emit(SocialErrorRegisterState());
    });
  }

  void userCreate({
    required userName,
    required userEmail,
    required userPhone,
    required uid,
  }) {
    SocialUserModel model = SocialUserModel(
      name: userName,
      email: userEmail,
      phone: userPhone,
      uid: uid,
      bio: 'Write your Bio ...',
      cover: 'https://img.freepik.com/premium-photo/planting-trees-urban-park-community-event_731930-188108.jpg?w=740',
      image: 'https://img.freepik.com/free-photo/view-cartoon-man-enjoying-delicious-3d-pizza_23-2151017617.jpg?t=st=1703313989~exp=1703317589~hmac=22885345b9786b539577fa151d7da49de7d12fca9121f446352f35014e6118c8&w=360',
      isEmailVerified: false
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    })
        .catchError((error) {
      emit(SocialCreateUserErrorState());
    });
  }
}
