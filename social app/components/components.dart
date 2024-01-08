import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/layout/news_app/cubit/cubit.dart';

import '../../modules/News_App/web_view/web_view.dart';

Widget defaultButton({
  double width = 100,
  double height = 50,
  Color background = Colors.blue,
  double? radius = 0,
  required Function() function,
  required String text,
  Color textColor = Colors.white,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: function,
        child: Text(text.toUpperCase(), style: TextStyle(fontSize: 20,color: textColor)),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        color: background,
      ),
    );

///////////////////////////////////////////////////////////

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required validate,
  required String label,
  IconData? prefix,
  suffixIcon,
  suffixFunction,
  submit,
  bool secret = false,
  Color? labelColor,
  FloatingLabelBehavior? behavior,
}) => TextFormField(
  validator: validate,
  controller: controller,
  keyboardType: type,
  obscureText: secret,
  onFieldSubmitted: submit,
  decoration: InputDecoration(
    floatingLabelBehavior: behavior,
      labelText: label,
      labelStyle: TextStyle(color: labelColor),
      prefixIcon: Icon(prefix),
      border: OutlineInputBorder(),
    suffixIcon: IconButton(
      onPressed: suffixFunction,
      icon: Icon(suffixIcon),
    )
  ),
);

Widget defaultGesture({
  required Function() function,
  double top = 6,
  double left = 15,
  Color color = Colors.yellow,
  required String num,
}) =>
    GestureDetector(
      onTap: function,
      child: Container(
        padding: EdgeInsets.only(top: top, left: left),
        child: Text(num,
            style: TextStyle(
              fontSize: 30,
            )),
        width: 50,
        height: 50,
        color: color,
      ),
    );

void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Widget),
    );
void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Widget),
      (route) => false,
    );


Widget defaultSeparator() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );

//العنصر الواحد
Widget defaultNewsItem(list, context) => InkWell(
      onTap: ()
      {
        navigateTo(context, Widget);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 150,
          child: Row(
            children: [
              Image(
                image: NetworkImage('${list['urlToImage']}'),
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${list['title']}',
                        style: Theme.of(context).textTheme.labelLarge,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${list['publishedAt']}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
