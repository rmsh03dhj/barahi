import 'package:bloc/bloc.dart';
import 'package:barahi/core/service_locator.dart';
import 'package:barahi/registration_or_login/data/models/user.dart';
import 'package:barahi/registration_or_login/domain/usecase/resend_confirmation_code_use_case.dart';
import 'package:barahi/registration_or_login/domain/usecase/sign_in_use_case.dart';
import 'package:barahi/registration_or_login/domain/usecase/sign_up_use_case.dart';
import 'package:barahi/registration_or_login/domain/usecase/verify_confirmation_code_use_case.dart';
import 'package:barahi/registration_or_login/presentation/bloc/registration_or_login_event.dart';
import 'package:barahi/registration_or_login/presentation/bloc/registration_or_login_state.dart';

class RegistrationOrLoginBloc extends Bloc<RegistrationOrLoginEvent, RegistrationOrLoginState> {
  final signUpUseCase = sl<SignUpUseCase>();
  final confirmCodeUseCase = sl<ConfirmCodeUseCase>();
  final resendConfirmCodeUseCase = sl<ResendConfirmCodeUseCase>();
  final signInUseCase = sl<SignInUseCase>();
  RegistrationOrLoginBloc() : super(RegistrationOrLoginInitialState());

  @override
  Stream<RegistrationOrLoginState> mapEventToState(RegistrationOrLoginEvent event) async* {
    if (event is SignUpPressed) {
      yield RegistrationOrLoginProcessingState();
      final failureOrValue =
          await signUpUseCase.execute(SignUpParams(password: event.password, email: event.email, phoneNumber: event.phoneNumber));
      yield failureOrValue.fold((failure) => SignUpFailedState(failure.failureMessage), (value) {
        return ConfirmRegistrationStepState(User(email: event.email));
      });
    }
    if (event is ConfirmCodeEntered) {
      yield RegistrationOrLoginProcessingState();
      final failureOrBool =
          await confirmCodeUseCase.execute(ConfirmCodeParams(email: event.email, code: event.code));
      yield failureOrBool.fold((failure) => SignUpFailedState(failure.failureMessage), (bool) {
        return SignUpSuccessState(event.email);
      });
    }
    if (event is SignInPressed) {
      yield RegistrationOrLoginProcessingState();
      final failureOrValue =
          await signInUseCase.execute(SignInParams(password: event.password, email: event.email));
      yield failureOrValue.fold((failure) => SignInFailedState(failure.failureMessage),
          (confirmSignInWithMFA) {
        return ConfirmRegistrationStepState(User(email: null));
      });
    }
    if (event is ResentButtonPressed) {
      yield RegistrationOrLoginProcessingState();
      final failureOrValue =
          await resendConfirmCodeUseCase.execute(ResendConfirmCodeParams(email: event.email));
      yield failureOrValue.fold((failure) => SignUpFailedState(failure.failureMessage), (value) {
        return ReSentConfirmCodeState();
      });
    }
  }
}
