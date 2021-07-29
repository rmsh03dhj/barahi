import 'dart:io';

import 'package:barahi/features/dashboard/domain/entities/image_details.dart';
import 'package:barahi/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:barahi/features/utils/constants/strings.dart';
import 'package:dartz/dartz.dart';
import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/core/usecases/base_use_case.dart';

abstract class SearchImageUseCase implements BaseUseCase<ImageDetails, String> {}

class SearchImageUseCaseImpl implements SearchImageUseCase {
  final dashboardRepo = sl<DashboardRepository>();
  @override
  Future<Either<Failure, ImageDetails>> execute(String searchText) async {
    try {
      final imageDetails = await dashboardRepo.searchImage(searchText);
      return Right(imageDetails);
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}
