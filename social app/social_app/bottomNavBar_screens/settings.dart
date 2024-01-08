import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layout/social_app/cubit/social_cubit.dart';
import 'package:flutter_project/layout/social_app/cubit/social_states.dart';
import 'package:flutter_project/modules/Social_App/edit_profile/edit_profile.dart';
import 'package:flutter_project/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        SocialCubit cubit = SocialCubit().get(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 230,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        width: double.infinity,
                        height: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage('${cubit.userModel?.cover}'),
                            )
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage('${cubit.userModel?.image}'),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                '${cubit.userModel?.name}',style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10,),
              Text(
                '${cubit.userModel?.bio}',style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text(
                              '100'
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'Posts',style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      )
                  ),
                  Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text(
                                '264'
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'Photos',style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      )
                  ),
                  Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text(
                                '10k'
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'Followers',style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      )
                  ),
                  Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text(
                                '55'
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'Followings',style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      )
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: (){},
                        child: Text(
                          'Add Photos',style: TextStyle(color: Colors.blue),
                        )
                    ),
                  ),
                  SizedBox(width: 15,),
                  OutlinedButton(
                      onPressed: ()
                      {
                        navigateTo(context, EditProfile());
                      },
                      child: Icon(Icons.edit, color: Colors.blue,)
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
