import 'dart:io';

import 'package:barahi/core/services/local_storage_service.dart';
import 'package:barahi/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/core/usecases/base_use_case.dart';

abstract class DeleteImageUseCase implements BaseUseCase<bool, DeleteImageInputParams> {}

class DeleteImageUseCaseImpl implements DeleteImageUseCase {
  final dashboardRepo = sl<DashboardRepository>();
  final localStorageService = sl<LocalStorageService>();
  @override
  Future<Either<Failure, bool>> execute(DeleteImageInputParams uploadImageInputParams) async {
    try {
      final uid = await localStorageService.readUid();
      await dashboardRepo.deleteImage(uploadImageInputParams.deleteImageFrom, uid, uploadImageInputParams.file);
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