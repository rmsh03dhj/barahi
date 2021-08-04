import 'dart:io';

class ImageDetails {
  final String url;
  final String fileName;
  final String uploadedAt;
  final bool myFavourite;
  final bool shared;

  ImageDetails({
    this.url,
    this.fileName,
    this.uploadedAt,
    this.shared = false,
    this.myFavourite = false,
  });

  ImageDetails.fromMap(Map<dynamic, dynamic> data)
      : url = data['url'],
        uploadedAt = data['uploaded_at'],
        myFavourite = data['myFavourite'],
        shared = data['shared'],
        fileName = data['fileName'];

  ImageDetails copyWith({
    String url,
    String fileName,
    String uploadedAt,
    bool myFavourite,
    bool shared,
  }) {
    return ImageDetails(
      url: url ?? this.url,
      fileName: fileName ?? this.fileName,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      myFavourite: myFavourite ?? this.myFavourite,
      shared: shared ?? this.shared,
    );
  }
}
