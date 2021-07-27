import 'package:barahi/core/routes/weather_app_routes.dart';
import 'package:barahi/core/services/navigation_service.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/features/dashboard/presentation/bloc/dashboard.dart';
import 'package:barahi/features/dashboard/presentation/pages/widgets/image_viewer.dart';
import 'package:barahi/features/utils/constants/strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/image_details.dart';

class ImageTile extends StatelessWidget {
  final ImageDetails imageDetail;

  const ImageTile({Key key, @required this.imageDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => sl<NavigationService>().navigateTo(MyAppRoutes.imageViewer,
          arguments: ImageViewerInput(imageDetail: imageDetail)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: imageDetail.url,
              fit: BoxFit.contain,
              errorWidget: (context, url, error) => Icon(Icons.access_alarms),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 32.0,
                width: 32.0,
                child: FittedBox(
                  child: FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Colors.white,
                    onPressed: () {},
                    child: Icon(
                      Icons.share,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: 32.0,
                width: 32.0,
                child: FittedBox(
                  child: FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Colors.white,
                    onPressed: () {
                      BlocProvider.of<DashboardBloc>(context).add(DeleteImage(
                          imageDetails: imageDetail,
                          deleteImageFrom: UPLOAD_IN));
                    },
                    child: Icon(
                      Icons.delete_forever,
                      size: 32,
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
