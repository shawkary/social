
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layout/social_app/cubit/social_cubit.dart';
import 'package:flutter_project/layout/social_app/cubit/social_states.dart';
import 'package:flutter_project/models/social_app_model/create_post_model.dart';
import 'package:flutter_project/modules/Social_App/bottomNavBar_screens/chat_details.dart';
import 'package:flutter_project/shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        SocialCubit cubit = SocialCubit().get(context);
        return BuildCondition(
          condition: cubit.posts.isNotEmpty,
          builder: (context) => SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  color: Colors.lightBlueAccent,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10,
                  margin: EdgeInsets.all(13),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage('https://img.freepik.com/free-photo/ai-generated-chicken-picture_23-2150653961.jpg?t=st=1703152531~exp=1703156131~hmac=11aa0d112afa06b09ac39e0aa14cda6297e3ed491855c18d11a6f0f1743e13f4&w=740'),
                        fit: BoxFit.cover,
                        height: 220,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          'Communicate with friends',style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(cubit.posts[index],cubit, index),
                    separatorBuilder: (context, index) => SizedBox(height: 10,),
                    itemCount: cubit.posts.length,
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget buildPostItem(CreatePostModel post, SocialCubit cubit, index) => Card(
      color: Colors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 7,
      margin: EdgeInsets.symmetric(horizontal: 13),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${post.image}'),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${post.name}',style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 7,),
                          Icon(Icons.check_circle,size: 20,color: Colors.blue,)
                        ],
                      ),
                      Text(
                        '${post.dateTime}',style: TextStyle(
                          color: Colors.grey[500]
                      ),
                      ),
                    ],
                  ),
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[400],
              ),
            ),
            Text(
                '${post.text}'
            ),
            SizedBox(height: 20,),
            if(post.postImage != '')
              Container(
              width: double.infinity,
              height: 170,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('${post.postImage}'),
                  )
              ),
            ),
            Row(
              children: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(color: Colors.red,Icons.heart_broken,size: 20,),
                        SizedBox(width: 4,),
                        Text(
                          '${cubit.likes[index]}',style: TextStyle(fontSize: 13,color: Colors.grey[500],height: 1),
                        )
                      ],
                    ),
                  ),
                  onTap: (){},
                ),
                Spacer(),
                InkWell(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(color: Colors.green,Icons.comment,size: 20,),
                      SizedBox(width: 4,),
                      Text(
                        '0',style: TextStyle(fontSize: 13,color: Colors.grey[500],height: 1.1),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        'comments',style: TextStyle(fontSize: 12,color: Colors.grey[500],height: 1.2),
                      ),
                    ],
                  ),
                  onTap: (){},
                ),
              ],),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[400],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: ()
                      {
                        cubit.commentPost(cubit.postsId[index]);
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage('${cubit.userModel!.image}'),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            child: Text(
                              'Write a comment ...',style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()
                    {
                      cubit.likePost(cubit.postsId[index]);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(color: Colors.red,Icons.heart_broken,size: 20,),
                        SizedBox(width: 8,),
                        Text(
                          'Like',style: TextStyle(fontSize: 13,color: Colors.grey,height: 1),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 30,),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(color: Colors.black,Icons.share,size: 18,),
                        SizedBox(width: 8,),
                        Text(
                          'Share',style: TextStyle(fontSize: 13,color: Colors.grey ,height: 1),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
  );
}
