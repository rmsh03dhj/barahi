import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RegistrationOrLoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegistrationOrLoginInitialState extends RegistrationOrLoginState {}

class RegistrationOrLoginProcessingState extends RegistrationOrLoginState {}

class SignUpSuccessState extends RegistrationOrLoginState {
  final User user;
  SignUpSuccessState(this.user);
}

class SignInFailedState extends RegistrationOrLoginState {
  final String errorMessage;
  SignInFailedState(this.errorMessage);
}

class SignUpFailedState extends RegistrationOrLoginState {
  final String errorMessage;
  SignUpFailedState(this.errorMessage);
}

class SignInSuccessState extends RegistrationOrLoginState {
  final User user;
  SignInSuccessState(this.user);
}
