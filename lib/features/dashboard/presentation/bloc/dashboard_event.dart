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
  ListImages();

  @override
  String toString() => 'ListImages';
}

class ListSharedImages extends DashboardEvent {
  ListSharedImages();

  @override
  String toString() => 'ListSharedImages';
}

class UploadImage extends DashboardEvent {
  final File file;
  final String fileName;

  UploadImage({required this.file, required this.fileName});

  @override
  String toString() => 'UploadImage';
}

class DeleteImage extends DashboardEvent {
  final ImageDetails imageDetails;

  DeleteImage({required this.imageDetails});

  @override
  String toString() => 'DeleteImage';
}

class UpdateImageDetails extends DashboardEvent {
  final ImageDetails imageDetails;

  UpdateImageDetails({required this.imageDetails});

  @override
  String toString() => 'UpdateImageDetails';
}

class SearchImage extends DashboardEvent {
  final String searchText;

  SearchImage({required this.searchText});

  @override
  String toString() => 'SearchImage';
}

class UpdateMyFavourite extends DashboardEvent {
  final ImageDetails imageDetails;

  UpdateMyFavourite({required this.imageDetails});

  @override
  String toString() => 'UpdateMyFavourite';
}

class ShareImage extends DashboardEvent {
  final ImageDetails imageDetails;

  ShareImage({required this.imageDetails});

  @override
  String toString() => 'ShareImage';
}

class SortByFileName extends DashboardEvent {
  final bool ascending;

  SortByFileName({this.ascending = true});

  @override
  String toString() => 'SortByFileName';
}

class SortByUploadedDate extends DashboardEvent {
  final bool ascending;

  SortByUploadedDate({this.ascending = true});

  @override
  String toString() => 'SortByUploadedDate';
}

class SortByMyFav extends DashboardEvent {
  final bool ascending;

  SortByMyFav({this.ascending = true});

  @override
  String toString() => 'SortByMyFav';
}
