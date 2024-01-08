import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layout/social_app/social_layout.dart';
import 'package:flutter_project/modules/Social_App/login_screen/cubit/cubit.dart';
import 'package:flutter_project/modules/Social_App/login_screen/cubit/states.dart';
import 'package:flutter_project/shared/network/local/cache_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../shared/components/components.dart';
import '../register_screen/social_register_screen.dart';

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({super.key});

  static final formKey = GlobalKey<FormState>();

  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (BuildContext context, state) {
          if(state is SocialSuccessLoginState){
            Fluttertoast.showToast(
                msg: "Login successfully",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
            CacheHelper.saveData(key: 'uid', value: state.uid).then((value){
              navigateAndFinish(context, SocialLayout());
            });
          }else if(state is SocialErrorLoginState){
            Fluttertoast.showToast(
                msg: "Invalid email or password",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        },
        builder: (BuildContext context, Object? state) {
          SocialLoginCubit cubit = SocialLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                        Text('login now to communicate with friends',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'This field can\'t be empty';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'This field can\'t be empty';
                              }
                              return null;
                            },
                            label: 'Password',
                            prefix: Icons.lock,
                            secret: cubit.obsecureText,
                            suffixIcon: cubit.obsecureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            suffixFunction: () {
                              cubit.changeEyePassword();
                            }),
                        SizedBox(
                          height: 40,
                        ),
                        BuildCondition(
                          condition: state is! SocialLoadingLoginState,
                          builder: (context) => Container(
                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.blue),
                            child: TextButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.postLoginData(
                                      userEmail: emailController.text,
                                      userPassword: passwordController.text,
                                    );
                                  }
                                },
                                child: Text(
                                  'Log in',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an acount ?',
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, SocialRegisterScreen());
                              },
                              child: Text(
                                'Register now',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
