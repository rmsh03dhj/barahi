import 'dart:io';

import 'package:barahi/features/dashboard/domain/entities/image_details.dart';
import 'package:barahi/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:barahi/features/utils/constants/strings.dart';
import 'package:dartz/dartz.dart';
import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/core/usecases/base_use_case.dart';
import 'package:flutter/foundation.dart';

abstract class SortImagesByFileNameUseCase implements BaseUseCase<List<ImageDetails>, bool> {}

class SortImagesByFileNameUseCaseImpl implements SortImagesByFileNameUseCase {
  final dashboardRepo = sl<DashboardRepository>();
  @override
  Future<Either<Failure, List<ImageDetails>>> execute(bool ascending) async {
    try {
      final result = await dashboardRepo.sortByFileName(ascending);
      return Right(result);
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}
