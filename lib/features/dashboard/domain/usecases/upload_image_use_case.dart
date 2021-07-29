import 'dart:io';

import 'package:barahi/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/core/usecases/base_use_case.dart';
import 'package:flutter/foundation.dart';

abstract class UploadImageUseCase implements BaseUseCase<bool, UploadImageInputParams> {}

class UploadImageUseCaseImpl implements UploadImageUseCase {
  final dashboardRepo = sl<DashboardRepository>();
  @override
  Future<Either<Failure, bool>> execute(UploadImageInputParams uploadImageInputParams) async {
    try {
      await dashboardRepo.uploadImage(
          uploadImageInputParams.fileToUpload, uploadImageInputParams.fileName);
      return Right(true);
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}

class UploadImageInputParams {
  final File fileToUpload;
  final String fileName;

  UploadImageInputParams({@required this.fileToUpload, @required this.fileName});
}
