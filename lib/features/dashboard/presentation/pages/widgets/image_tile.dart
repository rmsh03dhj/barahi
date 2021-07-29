import 'package:barahi/core/routes/my_app_routes.dart';
import 'package:barahi/core/services/navigation_service.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/features/dashboard/presentation/bloc/dashboard.dart';
import 'package:barahi/features/dashboard/presentation/pages/widgets/image_viewer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/image_details.dart';

class ImageTile extends StatefulWidget {
  final ImageDetails imageDetail;

  const ImageTile({Key key, @required this.imageDetail}) : super(key: key);

  @override
  _ImageTileState createState() => _ImageTileState();
}

class _ImageTileState extends State<ImageTile> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    isFav = widget.imageDetail.myFavourite;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => sl<NavigationService>().navigateTo(MyAppRoutes.imageViewer,
          arguments: ImageViewerInput(imageDetail: widget.imageDetail)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.width * 0.3,
        child: Stack(
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.5,
                child: CachedNetworkImage(
                  imageUrl: widget.imageDetail.url,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Icon(Icons.access_alarms),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 5,
              child: Container(
                height: 28.0,
                width: 28.0,
                child: FittedBox(
                  child: FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        isFav = !isFav;
                      });
                      BlocProvider.of<DashboardBloc>(context).add(UpdateMyFavourite(
                          imageDetails: widget.imageDetail.copyWith(myFavourite: isFav)));
                    },
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.black,
                      size: 36,
                    ),
                  ),
                ),
              ),
            ),
            widget.imageDetail.shared
                ? Container():
            Positioned(
              bottom: 10,
              right: 5,
              child: Container(
                height: 28.0,
                width: 28.0,
                child: FittedBox(
                  child: FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Colors.white,
                    onPressed: () {
                      BlocProvider.of<DashboardBloc>(context)
                          .add(DeleteImage(imageDetails: widget.imageDetail));
                    },
                    child: Icon(
                      Icons.delete_forever,
                      size: 36,
                    ),
                  ),
                ),
              ),
            ),
            widget.imageDetail.shared
                ? Container()
                : Positioned(
                    top: 10,
                    right: 40,
                    child: Container(
                      height: 28.0,
                      width: 28.0,
                      child: FittedBox(
                        child: FloatingActionButton(
                          heroTag: null,
                          backgroundColor: Colors.white,
                          onPressed: () {
                            BlocProvider.of<DashboardBloc>(context)
                                .add(ShareImage(imageDetails: widget.imageDetail));
                          },
                          child: Icon(
                            Icons.share,
                            size: 36,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
