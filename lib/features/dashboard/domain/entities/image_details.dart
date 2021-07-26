import 'package:flutter/foundation.dart';

class ImageDetails {
  final String url;
  final String fileName;
  final String uploadedBy;
  final String uploadedAt;
  final bool myFavourite;

  ImageDetails({
    @required this.url,
    @required this.fileName,
    @required this.uploadedBy,
    @required this.uploadedAt,
    @required this.myFavourite,
  });
}
