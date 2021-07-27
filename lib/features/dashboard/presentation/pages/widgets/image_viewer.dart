import 'package:barahi/features/dashboard/domain/entities/image_details.dart';
import 'package:barahi/features/utils/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  final ImageDetails imageDetail;

  const ImageViewer({Key key, @required this.imageDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
            imageDetail.fileName.split("/")[2],
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
                style: TextStyle(
                    color: Theme.of(context).disabledColor, fontSize: 14,),
              ),
            )
          ],
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            PhotoView(
              imageProvider: NetworkImage(
                imageDetail.url,
              ),
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 2,
              enableRotation: true,
              backgroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Theme.of(context).canvasColor,
              ),
              loadingBuilder: (context, event) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(uploadedBy),
                            Text(imageDetail.uploadedBy),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(uploadedAt),
                            Text(imageDetail.uploadedAt),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
