import 'package:barahi/utils/constants/strings.dart';
import 'package:dartz/dartz.dart';
import 'package:barahi/core/user_auth_service.dart';
import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/service_locator.dart';

import 'base_use_case.dart';

abstract class SignUpUseCase implements BaseUseCase<bool, SignUpParams> {}

class SignUpUseCaseImpl implements SignUpUseCase {
  final userAuthServiceService = sl<UserAuthService>();

  @override
  Future<Either<Failure, bool>> execute(SignUpParams signUpParams) async {
    try {
      final isSignedUp =
          await userAuthServiceService.signUp(signUpParams.email, signUpParams.phoneNumber, signUpParams.password);
      if (isSignedUp) {
        return Right(true);
      } else {
        return Left(GeneralFailure(failureMessage: signUpFailed));
      }
    } catch (e) {
      return Left(GeneralFailure(failureMessage: signUpFailed));
    }
  }
}

class SignUpParams {
  final String email;
  final String phoneNumber;
  final String password;

  SignUpParams({this.email, this.phoneNumber, this.password});
}
