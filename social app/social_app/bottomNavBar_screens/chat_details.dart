import 'package:flutter/material.dart';
import 'package:flutter_project/models/social_app_model/social_user_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({super.key, this.userModel});
   final SocialUserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage('${userModel!.image}')),
            SizedBox(width: 15,),
            Text('${userModel!.name}'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(20),
                    topEnd: Radius.circular(20),
                    topStart: Radius.circular(20),
                  ),
                  color: Colors.grey[300]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Hello bro',style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(20),
                    topEnd: Radius.circular(20),
                    topStart: Radius.circular(20),
                  ),
                  color: Colors.greenAccent
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Hello bro',style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey
                ),
                borderRadius: BorderRadius.circular(15)
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'type your message ...',
                          border: InputBorder.none,
                      )
                    ),
                  ),
                  Container(
                    width: 50,
                    child: MaterialButton(
                        height: 50,
                        color: Colors.blue,
                        onPressed: (){},
                        child: Icon(Icons.send, color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
