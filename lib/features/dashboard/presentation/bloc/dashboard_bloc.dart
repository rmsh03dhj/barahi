import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/features/dashboard/domain/usecases/dashboard_usecases.dart';
import 'package:bloc/bloc.dart';

import 'dashboard.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final uploadImageUseCase = sl<UploadImageUseCase>();
  final deleteImageUseCase = sl<DeleteImageUseCase>();
  final listImagesUseCase = sl<ListImagesUseCase>();
  final updateImageDetailsUseCase = sl<UpdateImageDetailsUseCase>();
  final searchImageUseCase = sl<SearchImageUseCase>();
  final sortByDateUseCase = sl<SortImagesByDateUseCase>();
  final sortByFileNameUseCase = sl<SortImagesByFileNameUseCase>();
  final sortByMyFavUseCase = sl<SortImagesByMyFavUseCase>();

  DashboardBloc() : super(DashboardEmpty());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is ListImages) {
      yield DashboardLoading();
      final failureOrImages =
          await listImagesUseCase.execute(false);
      yield failureOrImages.fold(
          (failure) => DashboardError(failure.failureMessage),
          (images) => DashboardLoaded(images));
    } if (event is ListSharedImages) {
      yield DashboardLoading();
      final failureOrImages =
          await listImagesUseCase.execute(true);
      yield failureOrImages.fold(
          (failure) => DashboardError(failure.failureMessage),
          (images) => SharedImageLoaded(images));
    }
    if (event is SortByFileName) {
      yield DashboardLoading();
      final failureOrImages =
          await sortByFileNameUseCase.execute(event.ascending);
      yield failureOrImages.fold(
          (failure) => DashboardError(failure.failureMessage),
          (images) => DashboardLoaded(images));
    }
    if (event is SortByUploadedDate) {
      yield DashboardLoading();
      final failureOrImages = await sortByDateUseCase.execute(event.ascending);
      yield failureOrImages.fold(
          (failure) => DashboardError(failure.failureMessage),
          (images) => DashboardLoaded(images));
    } if (event is SortByMyFav) {
      yield DashboardLoading();
      final failureOrImages = await sortByMyFavUseCase.execute(event.ascending);
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
    if (event is UpdateMyFavourite) {
      updateImageDetailsUseCase
          .execute(event.imageDetails)
          .then((value) => print("success"));
    }

    if (event is UpdateImageDetails) {
      yield DashboardLoading();
      updateImageDetailsUseCase
          .execute(event.imageDetails)
          .then((value) => print("success"));
      yield ImageDetailsUpdatedState();
    }
    if (event is SearchImage) {
      yield DashboardLoading();
      final failureOrImage = await searchImageUseCase.execute(event.searchText);
      yield failureOrImage.fold(
          (failure) => DashboardError(failure.failureMessage), (imageDetails) {
        if (imageDetails != null) {
          return DashboardLoaded([imageDetails]);
        } else {
          return ImageNotFoundState();
        }
      });
    }
  }
}
