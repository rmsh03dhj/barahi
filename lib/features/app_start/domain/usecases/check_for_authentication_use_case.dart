import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/core/usecases/base_use_case.dart';
import 'package:barahi/features/registration_or_login/domain/repositories/user_repository.dart';

abstract class CheckForAuthenticationUseCase implements BaseUseCase<User, NoParams> {}

class CheckForAuthenticationUseCaseImpl implements CheckForAuthenticationUseCase {
  final userRepository = sl<UserRepository>();

  @override
  Future<Either<Failure, User>> execute(NoParams noParams) async {
    try {
      final user = userRepository.getUser();
      return Right(user);
    } catch (e) {
      print(e);
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}

class NoParams {}
