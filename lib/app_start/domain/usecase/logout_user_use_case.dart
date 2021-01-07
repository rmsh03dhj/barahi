import 'package:dartz/dartz.dart';
import 'package:barahi/core/user_auth_service.dart';
import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/service_locator.dart';
import 'package:barahi/registration_or_login/domain/usecase/base_use_case.dart';

abstract class LogOutUserUseCase implements BaseUseCase<bool, NoParams> {}

class LogOutUserUseCaseImpl implements LogOutUserUseCase {
  final userAuthService = sl<UserAuthService>();

  @override
  Future<Either<Failure, bool>> execute(NoParams noParams) async {
    try {
      await userAuthService.signOut();
      return Right(true);
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}

class NoParams {
  NoParams();
}
