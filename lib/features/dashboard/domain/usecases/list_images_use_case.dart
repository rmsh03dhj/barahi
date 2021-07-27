import 'package:barahi/features/dashboard/domain/entities/image_details.dart';
import 'package:barahi/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/core/usecases/base_use_case.dart';

abstract class ListImagesUseCase
    implements BaseUseCase<List<ImageDetails>, String> {}

class ListImagesUseCaseImpl implements ListImagesUseCase {
  final dashboardRepo = sl<DashboardRepository>();

  @override
  Future<Either<Failure, List<ImageDetails>>> execute(
      String listImageFrom) async {
    try {
      final images = await dashboardRepo.loadImages(listImageFrom);
      return Right(images);
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}
