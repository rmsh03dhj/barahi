import 'package:equatable/equatable.dart';

import '../../domain/entities/image_details.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object> get props => [];
}

class DashboardEmpty extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<ImageDetails> images;

  DashboardLoaded(this.images);
}

class DashboardError extends DashboardState {
  final String errorMessage;

  DashboardError(this.errorMessage);
}

class ImageUploadedState extends DashboardState {
  ImageUploadedState();
}

class ImageDeletedState extends DashboardState {
  ImageDeletedState();
}
class ImageDetailsUpdatedState extends DashboardState {
  ImageDetailsUpdatedState();
}
