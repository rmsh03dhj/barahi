import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  Future<User> signIn(String email, String password);
  Future<User> signUp(String email, String password);
  Future<void> signOut();
  User getUser();
}
