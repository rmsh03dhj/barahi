import 'dart:io';

import 'package:barahi/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:barahi/features/utils/constants/strings.dart';
import 'package:dartz/dartz.dart';
import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/core/usecases/base_use_case.dart';

abstract class DeleteImageUseCase implements BaseUseCase<bool, String> {}

class DeleteImageUseCaseImpl implements DeleteImageUseCase {
  final dashboardRepo = sl<DashboardRepository>();
  @override
  Future<Either<Failure, bool>> execute(String url) async {
    try {
      await dashboardRepo.deleteImage(url);
      return Right(true);
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}
