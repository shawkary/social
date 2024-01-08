import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layout/social_app/cubit/social_cubit.dart';
import 'package:flutter_project/layout/social_app/cubit/social_states.dart';
import 'package:flutter_project/shared/components/components.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatelessWidget {
  static final formKey = GlobalKey<FormState>();

  static final emailController = TextEditingController();
  static final nameController = TextEditingController();
  static final bioController = TextEditingController();
  static final phoneController = TextEditingController();

  bool isImage = false;
  bool isCover = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {
        if(state is SocialProfileImagePickedSuccessState) {
            isImage = true;
          }else if(state is SocialUploadProfileImageSuccessState){
            isImage = false;
          }
        if(state is SocialCoverImagePickedSuccessState) {
            isCover = true;
          }else if(state is SocialUploadProfileCoverSuccessState){
            isCover = false;
          }
      },
      builder: (BuildContext context, Object? state) {
        SocialCubit cubit = SocialCubit().get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Edit Profile'
            ),
            actions: [
              TextButton(
                  onPressed: ()
                  {
                      cubit.updateUser(
                          userEmail: emailController.text,
                          userName: nameController.text,
                          userPhone: phoneController.text,
                          userBio: bioController.text,
                      );
                  },
                  child: Text(
                    'Update', style: TextStyle(color: Colors.blue),
                  )
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      height: 230,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: cubit.coverImage == null ? NetworkImage(
                                            '${cubit.userModel?.cover}') : Image.file(File(cubit.coverImage!.path)).image,
                                      )
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                      onPressed: ()
                                      {
                                        cubit.getCoverImage();
                                      },
                                      icon: Icon(Icons.camera_alt_outlined)
                                  ),
                                )
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 65,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: cubit.image == null ? NetworkImage('${cubit.userModel?.image}')
                                      : Image.file(File(cubit.image!.path)).image,
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                    onPressed: ()
                                    {
                                      cubit.getImage();
                                    },
                                    icon: Icon(Icons.camera_alt_outlined)
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      children: [
                        if(isImage == true)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                children: [
                                  MaterialButton(
                                    onPressed: ()
                                    {
                                      cubit.upLoadImage(
                                        userEmail: emailController.text,
                                        userName: nameController.text,
                                        userPhone: phoneController.text,
                                        userBio: bioController.text,
                                      );
                                    },
                                    child: Text('Upload image',style: TextStyle(color: Colors.white),),
                                    color: Colors.blue,
                                    height: 45,
                                  ),
                                  if(state is SocialUploadProfileImageLoadingState)
                                    LinearProgressIndicator(),
                                ],
                              ),
                            ),
                          ),
                        if(isCover == true)
                          Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                MaterialButton(
                                    onPressed: ()
                                    {
                                      cubit.upLoadCover(
                                        userEmail: emailController.text,
                                        userName: nameController.text,
                                        userPhone: phoneController.text,
                                        userBio: bioController.text,
                                      );
                                    },
                                    child: Text('Upload cover',style: TextStyle(color: Colors.white),),
                                    color: Colors.blue,
                                    height: 45,
                                  ),
                                if(state is SocialUploadProfileCoverLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                                                  ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Email must be not empty';
                        }
                        return null;
                      },
                      label: '${cubit.userModel!.email}',
                      prefix: Icons.email,
                      labelColor: Colors.grey,
                      behavior: FloatingLabelBehavior.never
                    ),
                    SizedBox(height: 20,),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Name must be not empty';
                        }
                        return null;
                      },
                      label: '${cubit.userModel!.name}',
                      prefix: Icons.person,
                      labelColor: Colors.grey,
                      behavior: FloatingLabelBehavior.never
                    ),
                    SizedBox(height: 20,),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Phone must be not empty';
                        }
                        return null;
                      },
                      label: '${cubit.userModel!.phone}',
                      prefix: Icons.call,
                      labelColor: Colors.grey,
                      behavior: FloatingLabelBehavior.never
                    ),
                    SizedBox(height: 20,),
                    defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Bio must be not empty';
                        }
                        return null;
                      },
                      label: '${cubit.userModel!.bio}',
                      prefix: Icons.info_outline,
                      labelColor: Colors.grey,
                      behavior: FloatingLabelBehavior.never
                    ),
                    SizedBox(height: 20,),
                    if(state is SocialLoadingUserUpdateState)
                      LinearProgressIndicator(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
