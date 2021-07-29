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
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {
        if (state is DashboardError) {
          Scaffold.of(context)
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 5),
              ),
            );
        }
        if (state is ImageDeletedState) {
          BlocProvider.of<DashboardBloc>(context)..add(ListImages());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                if (state is SharedImageLoaded) {
                  if (state.images.length != 0) {
                    return OrientationBuilder(builder: (context, orientation) {
                      return GridView.builder(
                          shrinkWrap: true,
                          itemCount: state.images.length,
                          physics: ClampingScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                            childAspectRatio: (10 / 9),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ImageTile(imageDetail: state.images[index]),
                            );
                          });
                    });
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
          ),
        );
      },
    );
  }
}
