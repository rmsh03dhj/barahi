import 'package:dartz/dartz.dart';
import 'package:barahi/core/user_auth_service.dart';
import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/service_locator.dart';
import 'package:barahi/registration_or_login/domain/usecase/base_use_case.dart';

import 'logout_user_use_case.dart';

abstract class CheckForAuthenticationUseCase implements BaseUseCase<bool, NoParams> {}

class CheckForAuthenticationUseCaseImpl implements CheckForAuthenticationUseCase {
  final userAuthService = sl<UserAuthService>();
  @override
  Future<Either<Failure, bool>> execute(NoParams noParams) async {
    try {
      final authenticated = await userAuthService.checkAuthenticated();
      return Right(authenticated);
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}
