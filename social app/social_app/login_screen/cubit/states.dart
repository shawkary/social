abstract class SocialLoginStates {}

class SocialInitialLoginState extends SocialLoginStates{}

class SocialSecurePasswordState extends SocialLoginStates{}

class SocialLoadingLoginState extends SocialLoginStates {}

class SocialSuccessLoginState extends SocialLoginStates {
  final String uid;

  SocialSuccessLoginState({required this.uid});
}

class SocialErrorLoginState extends SocialLoginStates {}