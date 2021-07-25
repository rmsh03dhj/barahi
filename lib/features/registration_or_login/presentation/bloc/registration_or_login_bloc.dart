import 'package:bloc/bloc.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/features/registration_or_login/domain/usecases/registration_or_login_usecases.dart';

import 'registration_or_login_event.dart';
import 'registration_or_login_state.dart';

class RegistrationOrLoginBloc extends Bloc<RegistrationOrLoginEvent, RegistrationOrLoginState> {
  final signUpUseCase = sl<SignUpUseCase>();
  final signInUseCase = sl<SignInUseCase>();
  RegistrationOrLoginBloc() : super(RegistrationOrLoginInitialState());

  @override
  Stream<RegistrationOrLoginState> mapEventToState(RegistrationOrLoginEvent event) async* {
    if (event is SignUpPressed) {
      yield RegistrationOrLoginProcessingState();
      final failureOrUser = await signUpUseCase.execute(SignUpParams(
        email: event.email,
        password: event.password,
      ));
      yield failureOrUser.fold((failure) => SignUpFailedState(failure.failureMessage),
          (user) => SignUpSuccessState(user));
    }
    if (event is SignInPressed) {
      yield RegistrationOrLoginProcessingState();
      final failureOrUser =
          await signInUseCase.execute(SignInParams(password: event.password, email: event.email));
      yield failureOrUser.fold((failure) => SignInFailedState(failure.failureMessage), (user) {
        return SignInSuccessState(user);
      });
    }
  }
}
