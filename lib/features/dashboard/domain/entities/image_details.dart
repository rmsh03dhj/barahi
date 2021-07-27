import 'dart:io';

class ImageDetails {
  final String url;
  final String fileName;
  final String uploadedAt;
  final bool myFavourite;

  ImageDetails({
    this.url,
    this.fileName,
    this.uploadedAt,
    this.myFavourite = false,
  });

  ImageDetails.fromMap(Map<dynamic, dynamic> data)
      : url = data['url'],
        uploadedAt = data['uploaded_at'],
        myFavourite = data['myFavourite'],
        fileName = data['fileName'];

  ImageDetails copyWith({
    String url,
    String fileName,
    String uploadedAt,
    bool myFavourite,
  }) {
    return ImageDetails(
        url: url ?? this.url,
        fileName: fileName ?? this.fileName,
        uploadedAt: uploadedAt ?? this.uploadedAt,
        myFavourite: myFavourite ?? this.myFavourite);
  }
}
