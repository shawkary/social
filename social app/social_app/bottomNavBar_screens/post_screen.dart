
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layout/social_app/cubit/social_cubit.dart';
import 'package:flutter_project/layout/social_app/cubit/social_states.dart';

import '../../../shared/components/components.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});


  static final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        SocialCubit cubit = SocialCubit().get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: ()
              {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text(
                'Add Post'
            ),
            actions: [
              TextButton(
                  onPressed: ()
                  {
                    var now = DateTime.now();
                    if(cubit.postImage == null){
                      cubit.createPost(
                          dateTime: now.toString(),
                          text: textController.text,
                        );
                  }else{
                        cubit.uploadPostImage(
                            text: textController.text,
                            dateTime: now.toString(),
                        );
                    }
                  },
                  child: Text(
                    'Post',
                    style: TextStyle(color: Colors.blue),
                  )
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(height: 15,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('https://img.freepik.com/premium-photo/happy-children-s-sitting-inside-school-bus_220873-45893.jpg?ga=GA1.1.1838090078.1702821936'),
                    ),
                    SizedBox(width: 20,),
                    Text(
                      'ibrahim shokry',style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'What is on your mind ...',
                      border: InputBorder.none,
                    ),

                  ),
                ),
                if(cubit.postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.file(File(cubit.postImage!.path)).image,
                          )
                      ),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue,
                      child: IconButton(
                          onPressed: ()
                          {
                            cubit.removePostImage();
                          },
                          icon: Icon(Icons.close)
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: ()
                        {
                          cubit.getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image,color: Colors.blue),
                            Text('add photoes',style: TextStyle(color: Colors.blue),),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.tag,color: Colors.blue,),
                            Text('tags',style: TextStyle(color: Colors.blue),),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
