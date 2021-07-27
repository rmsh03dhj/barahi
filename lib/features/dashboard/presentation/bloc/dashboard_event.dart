import 'dart:io';

import 'package:barahi/features/dashboard/domain/entities/image_details.dart';
import 'package:barahi/features/utils/constants/strings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ListImages extends DashboardEvent {
  final String listImagesFrom;

  ListImages({@required this.listImagesFrom});

  @override
  String toString() => 'ListImages';
}

class UploadImage extends DashboardEvent {
  final File file;
  final String fileName;
  final String uploadImageTo;

  UploadImage(
      {@required this.file,
      @required this.fileName,
      this.uploadImageTo = UPLOAD_IN});

  @override
  String toString() => 'UploadImage';
}

class DeleteImage extends DashboardEvent {
  final ImageDetails imageDetails;
  final String deleteImageFrom;

  DeleteImage({@required this.imageDetails, @required this.deleteImageFrom});

  @override
  String toString() => 'DeleteImage';
}

class UpdateImageDetails extends DashboardEvent {
  final ImageDetails imageDetails;

  UpdateImageDetails({@required this.imageDetails});

  @override
  String toString() => 'UpdateImageDetails';
}
