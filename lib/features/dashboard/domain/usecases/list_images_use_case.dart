import 'package:barahi/core/services/local_storage_service.dart';
import 'package:barahi/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:barahi/core/error/failure.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/core/usecases/base_use_case.dart';
import '../entities/image_details.dart';

abstract class ListImagesUseCase implements BaseUseCase<List<ImageDetails>, ListImagesInputParams> {}

class ListImagesUseCaseImpl implements ListImagesUseCase {
  final dashboardRepo = sl<DashboardRepository>();
  final localStorageService = sl<LocalStorageService>();

  @override
  Future<Either<Failure, List<ImageDetails>>> execute(ListImagesInputParams params) async {
    try {
      final uid= await localStorageService.readUid();
      final images = await dashboardRepo.loadImages(params.listImageFrom,  uid);
      return Right(images);
    } catch (e) {

      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}

class ListImagesInputParams {
  final String listImageFrom;
  final String uid;

  ListImagesInputParams(this.listImageFrom, this.uid);

}