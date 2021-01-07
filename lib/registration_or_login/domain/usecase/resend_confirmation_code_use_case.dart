import 'package:dartz/dartz.dart';
import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/user_auth_service.dart';
import 'package:barahi/core/service_locator.dart';
import 'package:barahi/registration_or_login/domain/usecase/base_use_case.dart';

abstract class ResendConfirmCodeUseCase implements BaseUseCase<bool, ResendConfirmCodeParams> {}

class ResendConfirmCodeUseCaseImpl implements ResendConfirmCodeUseCase {
  final userAuthServiceService = sl<UserAuthService>();

  @override
  Future<Either<Failure, bool>> execute(ResendConfirmCodeParams confirmCodeParams) async {
    try {
      await userAuthServiceService.resendSignUpCode(confirmCodeParams.email);
      return Right(true);
    } catch (e) {
      return Left(GeneralFailure(failureMessage: "Failed to sent verification code."));
    }
  }
}

class ResendConfirmCodeParams {
  final String email;

  ResendConfirmCodeParams({this.email});
}
