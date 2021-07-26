import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/features/app_start/domain/usecases/check_for_authentication_use_case.dart';
import 'package:barahi/features/registration_or_login/domain/repositories/user_repository.dart';

import 'app_start_event.dart';
import 'app_start_state.dart';

class AppStartBloc extends Bloc<AppStartEvent, AppStartState> {
  final userRepository = sl<UserRepository>();
  final checkForAuthenticationUseCase = sl<CheckForAuthenticationUseCase>();

  AppStartBloc() : super(Uninitialized());

  @override
  Stream<AppStartState> mapEventToState(
    AppStartEvent event,
  ) async* {
    if (event is CheckForAuthentication) {
      yield* _mapCheckForAuthenticationToState();
    }
    if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AppStartState> _mapCheckForAuthenticationToState() async* {
    final failureOrUser = await checkForAuthenticationUseCase.execute(NoParams());
    yield failureOrUser.fold((failure) => Unauthenticated(), (user) => Authenticated(user));
  }

  Stream<AppStartState> _mapLoggedOutToState() async* {
    userRepository.signOut();
    yield Unauthenticated();
  }
}
