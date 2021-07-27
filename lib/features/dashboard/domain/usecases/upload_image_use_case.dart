import 'package:barahi/features/dashboard/domain/entities/image_details.dart';
import 'package:barahi/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/core/usecases/base_use_case.dart';

abstract class UploadImageUseCase
    implements BaseUseCase<bool, UploadImageInputParams> {}

class UploadImageUseCaseImpl implements UploadImageUseCase {
  final dashboardRepo = sl<DashboardRepository>();
  @override
  Future<Either<Failure, bool>> execute(
      UploadImageInputParams uploadImageInputParams) async {
    try {
      await dashboardRepo.uploadImage(uploadImageInputParams.uploadImageTo,
          uploadImageInputParams.imageDetails);
      return Right(true);
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}

class UploadImageInputParams {
  final String uploadImageTo;
  final ImageDetails imageDetails;

  UploadImageInputParams(this.uploadImageTo, this.imageDetails);
}
