import 'package:barahi/features/utils/constants/strings.dart';
import 'package:bloc/bloc.dart';

import '../../../../core/services/service_locator.dart';
import '../../domain/usecases/dashboard_usecases.dart';
import '../../../../core/services/local_storage_service.dart';
import 'dashboard.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final uploadImageUseCase = sl<UploadImageUseCase>();
  final deleteImageUseCase = sl<DeleteImageUseCase>();
  final listImagesUseCase = sl<ListImagesUseCase>();
  final localStorageService = sl<LocalStorageService>();

  DashboardBloc() : super(DashboardEmpty());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    final uid = await localStorageService.readUid();
    if (event is ListImages) {
      yield DashboardLoading();
      final failureOrImages = await listImagesUseCase.execute(ListImagesInputParams(event.listImagesFrom, uid));
      yield failureOrImages.fold((failure) => DashboardError(failure.failureMessage),
              (images) => DashboardLoaded(images));
    }
    if (event is DeleteImage) {
      yield DashboardLoading();
      final failureOrUser = await deleteImageUseCase.execute(DeleteImageInputParams(UPLOAD_IN, event.imageDetails.name));
      failureOrUser.fold((failure) => DashboardError(failure.failureMessage),
              (user) => add(ListImages(listImagesFrom: UPLOAD_IN)));
    }
    if (event is UploadImage) {
      yield DashboardLoading();
      final failureOrUser = await uploadImageUseCase.execute(UploadImageInputParams(UPLOAD_IN, event.file));
      failureOrUser.fold((failure) => DashboardError(failure.failureMessage),
              (user) => add(ListImages(listImagesFrom: UPLOAD_IN)));
    }
  }
}
