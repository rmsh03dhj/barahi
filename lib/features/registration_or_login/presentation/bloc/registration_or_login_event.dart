import 'package:equatable/equatable.dart';

abstract class RegistrationOrLoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpPressed extends RegistrationOrLoginEvent {
  final String email;
  final String password;

  SignUpPressed(this.email, this.password);
}

class SignInPressed extends RegistrationOrLoginEvent {
  final String email;
  final String password;

  SignInPressed(this.email, this.password);
}

class ConfirmCodeEntered extends RegistrationOrLoginEvent {
  final String code;
  final String email;

  ConfirmCodeEntered(this.code, this.email);
}

class ResentButtonPressed extends RegistrationOrLoginEvent {
  final String email;

  ResentButtonPressed(this.email);
}
