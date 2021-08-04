import 'package:firebase_auth/firebase_auth.dart';
import 'package:barahi/features/registration_or_login/domain/repositories/user_repository.dart';
import 'package:barahi/features/utils/constants/strings.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  User getUser() {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        return currentUser;
      } else {
        throw errorMessageSomethingWentWrong;
      }
    } catch (e) {
      throw errorMessageSomethingWentWrong;
    }
  }

  @override
  Future<User> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user!;
    } on FirebaseException catch (e, s) {
      if (e.code == "user-not-found") {
        throw errorMessageNoAccountFoundForEmail;
      } else if (e.code == "wrong-password") {
        throw errorMessageInvalidPasswordOrNoPassword;
      } else if (e.code == "network-request-failed") {
        throw noInternetConnection;
      } else {
        throw errorMessageSomethingWentWrong;
      }
    } catch (e) {
      throw errorMessageSomethingWentWrong;
    }
  }

  @override
  Future<User> signUp(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user!;
    } on FirebaseException catch (e) {
      if (e.code == "email-already-in-use") {
        throw errorMessageEmailUsed;
      } else if (e.code == "wrong-password") {
        throw errorMessageInvalidPasswordOrNoPassword;
      } else if (e.code == "network-request-failed") {
        throw noInternetConnection;
      } else {
        throw errorMessageSomethingWentWrong;
      }
    } catch (e) {
      throw errorMessageSomethingWentWrong;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw errorMessageSomethingWentWrong;
    }
  }
}
