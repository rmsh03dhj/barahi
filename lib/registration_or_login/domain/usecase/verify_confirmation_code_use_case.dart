import 'package:dartz/dartz.dart';
import 'package:barahi/core/user_auth_service.dart';
import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/service_locator.dart';
import 'package:barahi/utils/constants/strings.dart';

import 'base_use_case.dart';

abstract class ConfirmCodeUseCase
    implements BaseUseCase<bool, ConfirmCodeParams> {}

class ConfirmCodeUseCaseImpl implements ConfirmCodeUseCase {
  final userAuthServiceService = sl<UserAuthService>();

  @override
  Future<Either<Failure, bool>> execute(
      ConfirmCodeParams confirmCodeParams) async {
    try {
      bool codeConfirmed = false;
      if (confirmCodeParams.email == null) {
        codeConfirmed =
            await userAuthServiceService.confirmSignIn(confirmCodeParams.code);
      } else {
        codeConfirmed = await userAuthServiceService.confirmSignUp(
            confirmCodeParams.email, confirmCodeParams.code);
      }
      if (codeConfirmed) {
        return Right(true);
      } else {
        return Left(GeneralFailure(failureMessage: codeVerificationFailed));
      }
    } catch (e) {
      return Left(GeneralFailure(failureMessage: codeVerificationFailed));
    }
  }
}

class ConfirmCodeParams {
  final String email;
  final String code;

  ConfirmCodeParams({this.email, this.code});
}
