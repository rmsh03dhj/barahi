import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/features/dashboard/domain/usecases/dashboard_usecases.dart';
import 'package:barahi/features/dashboard/domain/usecases/update_image_details_use_case.dart';
import 'package:barahi/features/utils/constants/strings.dart';
import 'package:bloc/bloc.dart';

import 'dashboard.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final uploadImageUseCase = sl<UploadImageUseCase>();
  final deleteImageUseCase = sl<DeleteImageUseCase>();
  final listImagesUseCase = sl<ListImagesUseCase>();
  final updateImageDetailsUseCase = sl<UpdateImageDetailsUseCase>();

  DashboardBloc() : super(DashboardEmpty());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is ListImages) {
      yield DashboardLoading();
      final failureOrImages =
          await listImagesUseCase.execute(event.listImagesFrom);
      yield failureOrImages.fold(
          (failure) => DashboardError(failure.failureMessage),
          (images) => DashboardLoaded(images));
    }
    if (event is DeleteImage) {
      yield DashboardLoading();
      final failureOrUser = await deleteImageUseCase
          .execute(DeleteImageInputParams(url: event.imageDetails.url));
      yield failureOrUser.fold(
          (failure) => DashboardError(failure.failureMessage),
          (user) => ImageDeletedState());
    }
    if (event is UploadImage) {
      yield DashboardLoading();
      final failureOrUploaded = await uploadImageUseCase.execute(
          UploadImageInputParams(
              fileToUpload: event.file, fileName: event.fileName));
      yield failureOrUploaded.fold(
          (failure) => DashboardError(failure.failureMessage),
          (uploaded) => ImageUploadedState());
    }
    if (event is UpdateImageDetails) {
      yield DashboardLoading();
      updateImageDetailsUseCase
          .execute(event.imageDetails)
          .then((value) => add(ListImages(listImagesFrom: UPLOAD_IN)));
    }
  }
}
