import 'package:get_it/get_it.dart';
import 'package:barahi/core/user_auth_service.dart';
import 'package:barahi/app_start/domain/usecase/check_for_authentication_use_case.dart';
import 'package:barahi/app_start/domain/usecase/logout_user_use_case.dart';
import 'package:barahi/app_start/presentation/bloc/app_start_bloc.dart';
import 'package:barahi/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:barahi/registration_or_login/domain/usecase/resend_confirmation_code_use_case.dart';
import 'package:barahi/registration_or_login/domain/usecase/sign_in_use_case.dart';
import 'package:barahi/registration_or_login/domain/usecase/sign_up_use_case.dart';
import 'package:barahi/registration_or_login/domain/usecase/verify_confirmation_code_use_case.dart';
import 'package:barahi/registration_or_login/presentation/bloc/registration_or_login_bloc.dart';

import 'navigation_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///bloc
  sl.registerFactory(() => RegistrationOrLoginBloc());
  sl.registerFactory(() => AppStartBloc());
  sl.registerFactory(() => DashBoardBloc());

  ///sign up use case
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCaseImpl());
  sl.registerLazySingleton<ConfirmCodeUseCase>(() => ConfirmCodeUseCaseImpl());
  sl.registerLazySingleton<ResendConfirmCodeUseCase>(() => ResendConfirmCodeUseCaseImpl());

  ///app start use case
  sl.registerLazySingleton<CheckForAuthenticationUseCase>(
      () => CheckForAuthenticationUseCaseImpl());
  sl.registerLazySingleton<LogOutUserUseCase>(() => LogOutUserUseCaseImpl());

  ///sign in use case
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCaseImpl());

  ///other services
  sl.registerLazySingleton(() => NavigationService());
  sl.registerLazySingleton<UserAuthService>(() => UserAuthServiceImpl());
}
