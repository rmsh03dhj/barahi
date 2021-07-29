import 'package:barahi/features/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dashboard.dart';
import 'widgets/image_tile.dart';

class SharedImages extends StatefulWidget {
  @override
  _SharedImagesState createState() => _SharedImagesState();
}

class _SharedImagesState extends State<SharedImages> {

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is SharedImageLoaded) {
            if (state.images.length != 0) {
              return SingleChildScrollView(
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: state.images.length,
                    physics: ClampingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (6 / 8),
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ImageTile(imageDetail: state.images[index]),
                      );
                    }),
              );
            } else {
              return Center(child: Text(noImages));
            }
          }
          if (state is DashboardLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text(noImages));
          }
        },
      ),
    );
  }
}
