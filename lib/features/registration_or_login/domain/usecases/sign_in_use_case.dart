import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/core/usecases/base_use_case.dart';
import 'package:barahi/features/registration_or_login/domain/repositories/user_repository.dart';
import 'package:barahi/features/utils/constants/strings.dart';

abstract class SignInUseCase implements BaseUseCase<User, SignInParams> {}

class SignInUseCaseImpl implements SignInUseCase {
  final userRepository = sl<UserRepository>();
  @override
  Future<Either<Failure, User>> execute(SignInParams signUpParams) async {
    try {
      final user = await userRepository.signIn(signUpParams.email, signUpParams.password);

      if (user != null) {
        return Right(user);
      } else {
        userRepository.signOut();
        return Left(GeneralFailure(failureMessage: pleaseTryAgain));
      }
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}
