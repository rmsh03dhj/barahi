import 'package:equatable/equatable.dart';
import 'package:barahi/registration_or_login/data/models/user.dart';

abstract class RegistrationOrLoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegistrationOrLoginInitialState extends RegistrationOrLoginState {}

class RegistrationOrLoginProcessingState extends RegistrationOrLoginState {}

class SignUpSuccessState extends RegistrationOrLoginState {
  final String email;
  SignUpSuccessState(this.email);
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
  final String email;
  SignInSuccessState(this.email);
}

class ConfirmRegistrationStepState extends RegistrationOrLoginState {
  final User user;

  ConfirmRegistrationStepState(this.user);
}

class ReSentConfirmCodeState extends RegistrationOrLoginState {
  ReSentConfirmCodeState();
}
