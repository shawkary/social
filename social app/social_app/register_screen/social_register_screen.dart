import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/modules/Social_App/register_screen/cubit/cubit.dart';
import 'package:flutter_project/modules/Social_App/register_screen/cubit/states.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../layout/social_app/social_layout.dart';
import '../../../shared/components/components.dart';

class SocialRegisterScreen extends StatelessWidget {
  const SocialRegisterScreen({super.key});

  static final formKey = GlobalKey<FormState>();

  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();
  static final nameController = TextEditingController();
  static final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (BuildContext context, state) {
          if(state is SocialCreateUserSuccessState){
            Fluttertoast.showToast(
                msg: "Successfully registered",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );

            navigateAndFinish(context, SocialLayout());
          };
        },
        builder: (BuildContext context, Object? state) {
          SocialRegisterCubit cubit = SocialRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value)
                          {
                            if(value.isEmpty){
                              return 'email must not be empty';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email,
                        ),
                        SizedBox(height: 20,),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (value)
                            {
                              if(value.isEmpty){
                                return 'Password must not be empty';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock,
                            secret: cubit.isSecret,
                            suffixIcon: cubit.isSecret? Icons.visibility : Icons.visibility_off,
                            suffixFunction: ()
                            {
                              cubit.changeIconPassword();
                            }
                        ),
                        SizedBox(height: 20,),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value)
                          {
                            if(value.isEmpty){
                              return 'Name must not be empty';
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(height: 20,),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value)
                            {
                              if(value.isEmpty){
                                return 'Phone must not be empty';
                              }
                            },
                            label: 'Phone',
                            prefix: Icons.phone
                        ),
                        SizedBox(height: 20,),
                        BuildCondition(
                          condition: state is !SocialLoadingRegisterState,
                          builder: (context) => defaultButton(
                            function: ()
                            {
                              if(formKey.currentState!.validate()){
                                cubit.postRegisterData(
                                    userEmail: emailController.text,
                                    userPassword: passwordController.text,
                                    userName: nameController.text,
                                    userPhone: phoneController.text,
                                );
                              }
                            },
                            text: 'Register',
                            width: double.infinity,
                            height: 60,
                            radius: 8
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
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
