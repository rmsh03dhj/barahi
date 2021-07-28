import 'package:equatable/equatable.dart';

import '../../domain/entities/image_details.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object> get props => [];
}

class DashboardEmpty extends DashboardState {}

class DashboardLoading extends DashboardState {}
class ImageSearching extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<ImageDetails> images;

  DashboardLoaded(this.images);
}

class DashboardError extends DashboardState {
  final String errorMessage;

  DashboardError(this.errorMessage);
}class ImageFoundState extends DashboardState {
  final ImageDetails imageDetails;

  ImageFoundState(this.imageDetails);
}

class ImageUploadedState extends DashboardState {
  ImageUploadedState();
}class ImageNotFoundState extends DashboardState {
  ImageNotFoundState();
}

class ImageDeletedState extends DashboardState {
  ImageDeletedState();
}
class ImageDetailsUpdatedState extends DashboardState {
  ImageDetailsUpdatedState();
}
