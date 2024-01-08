import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layout/social_app/cubit/social_states.dart';
import 'package:flutter_project/models/social_app_model/social_user_model.dart';
import 'package:flutter_project/shared/components/constants.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/social_app_model/create_post_model.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool plus = false;

  void changeCurrentIndex(index)
  {
    if(index == 1) {
      getUsers();
    }
    if(index == 2) {
      emit(SocialNewPostState());
    }else{
      if(index == 3 || index == 4){
        plus = true;
        currentIndex = index - 1;
      }else{
        plus = false;
        currentIndex = index;
      }
      emit(SocialChangeCurrentIndexState());
    }
  }


  SocialUserModel? userModel;

  void getUserData(){
    emit(SocialGetUserLoadingState());
         FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value){
          userModel = SocialUserModel.fromJson(value.data()!);
          print(userModel?.isEmailVerified);
          emit(SocialGetUserSuccessState());
    })
        .catchError((error) {
          emit(SocialGetUserErrorState());
    });
  }


  XFile? image;
  ImagePicker picker = ImagePicker();

  Future getImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    emit(SocialProfileImagePickedSuccessState());
  }

  XFile? coverImage;
  Future getCoverImage() async {
    coverImage = await picker.pickImage(source: ImageSource.gallery);
    emit(SocialCoverImagePickedSuccessState());
  }

/////////////////////////////////////////////////////////////////////////

  void upLoadImage({
    required userEmail,
    required userName,
    required userPhone,
    required userBio,
}) {
    FirebaseStorage.instanceFor(bucket: "gs://shawkary-app.appspot.com");
    emit(SocialUploadProfileImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(image!.path).pathSegments.last}')
        .putFile(File(image!.path))
        .then((value)
    {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(
          userEmail: userEmail == '' ? userModel!.email : userEmail,
          userName: userName == '' ? userModel!.name : userName,
          userPhone: userPhone == '' ? userModel!.phone : userPhone,
          userBio: userBio == '' ? userModel!.bio : userBio,
          image: value,
        );
      }).catchError((error){
        emit(SocialUploadProfileImageErrorState());
      });
    })
        .catchError((error){
          emit(SocialUploadProfileImageErrorState());
    });
  }

//////////////////////////////////////////////////////////////////////////

  void upLoadCover({
    required userEmail,
    required userName,
    required userPhone,
    required userBio,
  }) {
    FirebaseStorage.instanceFor(bucket: "gs://shawkary-app.appspot.com");
    emit(SocialUploadProfileCoverLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(File(coverImage!.path))
        .then((value)
    {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadProfileCoverSuccessState());
        print(value);
        updateUser(
          userEmail: userEmail == '' ? userModel!.email : userEmail,
          userName: userName == '' ? userModel!.name : userName,
          userPhone: userPhone == '' ? userModel!.phone : userPhone,
          userBio: userBio == '' ? userModel!.bio : userBio,
          cover: value,
        );
      }).catchError((error){
        emit(SocialUploadProfileCoverErrorState());
      });
    })
        .catchError((error){
      emit(SocialUploadProfileCoverErrorState());
    });
  }

//////////////////////////////////////////////////////////////////////////

  XFile? postImage;
  Future getPostImage() async {
    postImage = await picker.pickImage(source: ImageSource.gallery);
    emit(SocialCreatePostImageState());
  }

  void uploadPostImage({
    required text,
    required dateTime,
  }) {
    FirebaseStorage.instanceFor(bucket: "gs://shawkary-app.appspot.com");
    emit(SocialCreatePostLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('Posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(File(postImage!.path))
        .then((value)
    {
      value.ref.getDownloadURL().then((value) {
        emit(SocialCreatePostSuccessState());
        print(value);
        createPost(
            dateTime: dateTime,
            text: text,
            postImage: value,
        );
      }).catchError((error){
        emit(SocialCreatePostErrorState());
      });
    })
        .catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }
//////////////////////////////////////////////////////////////////////////

  void removePostImage()
  {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

//////////////////////////////////////////////////////////////////////////

  void createPost({
    required dateTime,
    required text,
    postImage,
  })
  {
    emit(SocialLoadingUserUpdateState());
    CreatePostModel postModel = CreatePostModel(
        name: userModel!.name,
        image: userModel!.image,
        uid: userModel!.uid,
        dateTime: dateTime,
        text: text,
        postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value)
    {
      emit(SocialCreatePostSuccessState());
    })
        .catchError((error)
    {
      emit(SocialCreatePostErrorState());
    });
  }
//////////////////////////////////////////////////////////////////////////

  List<CreatePostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts()
  {
    emit(SocialGetPostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            element.reference
              .collection('likes')
              .get()
              .then((value)
                {
                  likes.add(value.docs.length);
                  postsId.add(element.id);
                  posts.add(CreatePostModel.fromJson(element.data()));
                  emit(SocialGetLikeSuccessState());
                })
              .catchError((error){
                emit(SocialGetLikeErrorState());
            });
          });
          print('suiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
          emit(SocialGetPostSuccessState());
    })
        .catchError((error){
          print(error.toString());
          emit(SocialGetPostErrorState());
    });
  }
//////////////////////////////////////////////////////////////////////////

  void likePost(String postId)
  {
    FirebaseFirestore.instance
      .collection('posts')
      .doc(postId)
      .collection('likes')
      .doc(userModel?.uid)
      .set({
      'likes':true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error){
      emit(SocialLikePostErrorState());
    });

  }
//////////////////////////////////////////////////////////////////////////

  void commentPost(String postId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel?.uid)
        .set({
      'comments':true,
    }).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error){
      emit(SocialCommentPostErrorState());
    });
  }

//////////////////////////////////////////////////////////////////////////

  void updateUser({
      userEmail,
      userName,
      userPhone,
      userBio,
      String? image,
      String? cover,
})
  {
    emit(SocialLoadingUserUpdateState());
    SocialUserModel model = SocialUserModel(
        email: userEmail == '' ? userModel!.email : userEmail,
        name: userName == '' ? userModel!.name : userName,
        phone: userPhone == '' ? userModel!.phone : userPhone,
        uid: userModel!.uid,
        bio: userBio == '' ? userModel!.bio : userBio,
        cover: cover ?? userModel!.cover,
        image: image ?? userModel!.image,
        isEmailVerified: false
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update(model.toMap())
        .then((value)
    {
        getUserData();
    })
        .catchError((error)
    {
      emit(SocialUserUpdateErrorState());
    });
  }

  List<SocialUserModel> users = [];

  void getUsers()
  {
    if(users.length == 0)
      FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((value) {
            value.docs.forEach((element) {
              // if(element.data()['uid'] != userModel!.uid)
                users.add(SocialUserModel.fromJson(element.data()));
            emit(SocialGetAllUsersSuccessState());
        });
      })
          .catchError((error){
        print(error.toString());
        emit(SocialGetAllUsersErrorState());
      });
    }
}












