import 'dart:io';

import 'package:barahi/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/core/usecases/base_use_case.dart';

abstract class DeleteImageUseCase
    implements BaseUseCase<bool, DeleteImageInputParams> {}

class DeleteImageUseCaseImpl implements DeleteImageUseCase {
  final dashboardRepo = sl<DashboardRepository>();
  @override
  Future<Either<Failure, bool>> execute(
      DeleteImageInputParams uploadImageInputParams) async {
    try {
      await dashboardRepo.deleteImage(
          uploadImageInputParams.deleteImageFrom, uploadImageInputParams.file);
      return Right(true);
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}

class DeleteImageInputParams {
  final String deleteImageFrom;
  final String file;

  DeleteImageInputParams(this.deleteImageFrom, this.file);
}
