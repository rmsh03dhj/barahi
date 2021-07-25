
import 'package:get_it/get_it.dart';
import 'package:barahi/core/services/navigation_service.dart';
import 'package:barahi/features/app_start/domain/usecases/check_for_authentication_use_case.dart';
import 'package:barahi/features/app_start/presentation/bloc/app_start_bloc.dart';
import 'package:barahi/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:barahi/features/dashboard/domain/repositories/weather_repository.dart';
import 'package:barahi/features/dashboard/presentation/bloc/dashboard.dart';
import 'package:barahi/features/registration_or_login/data/repositories/user_repository_impl.dart';
import 'package:barahi/features/registration_or_login/domain/repositories/user_repository.dart';
import 'package:barahi/features/registration_or_login/domain/usecases/registration_or_login_usecases.dart';
import 'package:barahi/features/registration_or_login/presentation/bloc/registration_or_login.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///blocs
  sl.registerFactory(() => AppStartBloc());
  sl.registerFactory(() => RegistrationOrLoginBloc());
  sl.registerFactory(() => DashboardBloc());

  ///use cases
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCaseImpl());
  sl.registerLazySingleton<CheckForAuthenticationUseCase>(
      () => CheckForAuthenticationUseCaseImpl());
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCaseImpl());

  ///repositories
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  sl.registerLazySingleton<DashboardRepository>(() => DashboardRepositoryImpl());

  ///services
  sl.registerLazySingleton(() => NavigationService());
}
