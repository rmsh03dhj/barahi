import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';

abstract class UserAuthService {
  Future<bool> signIn(String email, String password);

  Future<bool> confirmSignIn(String confirmationCode);
  Future<bool> confirmSignUp(String email, String confirmationCode);

  Future<void> resendSignUpCode(String email);

  Future<bool> checkAuthenticated();

  Future<bool> signUp(String email, String phoneNumber, String password);

  Future<void> signOut();
}

class UserAuthServiceImpl implements UserAuthService {
  Future<bool> signIn(String email, String password) async {
    try {
      final signInResult = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );
      return signInResult.nextStep.signInStep == 'CONFIRM_SIGN_IN_WITH_SMS_MFA_CODE';
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> resendSignUpCode(String email) async {
    try {
      await Amplify.Auth.resendSignUpCode(username: email);
    } catch (e) {
      throw (e);
    }
  }

  Future<bool> checkAuthenticated() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      return session.isSignedIn;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUp(String email, String phoneNumber, String password) async {
    try {
      Map<String, dynamic> userAttributes = {
        "email": email,
        "phone_number": phoneNumber,
      };

      final signUpResult = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      return signUpResult.nextStep.signUpStep == 'CONFIRM_SIGN_UP_STEP';
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<bool> confirmSignUp(String email, String confirmationCode) async {
    try {
      final signUpRequest = await Amplify.Auth.confirmSignUp(
        username: email,
        confirmationCode: confirmationCode,
      );
      return signUpRequest.isSignUpComplete &&
          signUpRequest.nextStep.signUpStep == 'DONE';
    } catch (e) {
      throw (e);
    }
  } 
  
   Future<bool> confirmSignIn(String confirmationCode) async {
    try {
      final signInRequest = await Amplify.Auth.confirmSignIn(
        confirmationValue: confirmationCode,
      );
      return signInRequest.isSignedIn &&
          signInRequest.nextStep.signInStep == 'DONE';
    } catch (e) {
      throw (e);
    }
  }

  Future<void> signOut() async {
    try {

//await AmplifyAuthCognito


      await Amplify.Auth.signOut(
        options: CognitoSignOutOptions(
          globalSignOut: true,
        ),
      );
    } catch (e) {
      throw (e);
    }
  }
}
