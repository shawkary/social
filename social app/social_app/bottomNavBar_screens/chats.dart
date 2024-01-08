
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layout/social_app/cubit/social_cubit.dart';
import 'package:flutter_project/layout/social_app/cubit/social_states.dart';
import 'package:flutter_project/models/social_app_model/social_user_model.dart';
import 'package:flutter_project/modules/Social_App/bottomNavBar_screens/chat_details.dart';

import '../../../shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        SocialCubit cubit = SocialCubit().get(context);
        return BuildCondition(
          condition: cubit.users.isNotEmpty,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildChatItem(cubit.users[index], context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[400],
              ),
            ),
            itemCount: cubit.users.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel user, context) => InkWell(
    onTap: ()
    {
      navigateTo(context, ChatDetailsScreen(
        userModel: user,
      ));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    '${user.image}'),
              ),
              SizedBox(width: 20,),
              Text(
                '${user.name}', style: TextStyle(fontSize: 16),
              ),
            ],
          ),
    ),
  );
}
