import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barahi/core/service_locator.dart';
import 'package:barahi/app_start/domain/usecase/check_for_authentication_use_case.dart';
import 'package:barahi/app_start/domain/usecase/logout_user_use_case.dart';

import 'app_start_event.dart';
import 'app_start_state.dart';

class AppStartBloc extends Bloc<AppStartEvent, AppStartState> {
  final checkForAuthenticationUseCase = sl<CheckForAuthenticationUseCase>();
  final logOutUserUseCase = sl<LogOutUserUseCase>();
  AppStartBloc() : super(Uninitialized());

  @override
  Stream<AppStartState> mapEventToState(
    AppStartEvent event,
  ) async* {
    if (event is CheckForAuthentication) {
      final failureOrUser = await checkForAuthenticationUseCase.execute(NoParams());
      yield failureOrUser.fold((failure) => Unauthenticated(), (authenticated) {
        if (authenticated) {
          return Authenticated();
        } else {
          return Unauthenticated();
        }
      });
    }
    if (event is LoggedOut) {
      final failureOrBool = await logOutUserUseCase.execute(NoParams());
      yield failureOrBool.fold((failure) => Unauthenticated(), (bool) {
        return Unauthenticated();
      });
    }
  }
}
