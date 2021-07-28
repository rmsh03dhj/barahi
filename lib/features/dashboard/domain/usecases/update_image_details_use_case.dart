import 'dart:io';

import 'package:barahi/features/dashboard/domain/entities/image_details.dart';
import 'package:barahi/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:barahi/features/utils/constants/strings.dart';
import 'package:dartz/dartz.dart';
import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/core/usecases/base_use_case.dart';

abstract class UpdateImageDetailsUseCase
    implements BaseUseCase<bool, ImageDetails> {}

class UpdateImageDetailsUseCaseImpl implements UpdateImageDetailsUseCase {
  final dashboardRepo = sl<DashboardRepository>();
  @override
  Future<Either<Failure, bool>> execute(ImageDetails imageDetails) async {
    try {
      await dashboardRepo.updateImageDetails(imageDetails);
      return Right(true);
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}
