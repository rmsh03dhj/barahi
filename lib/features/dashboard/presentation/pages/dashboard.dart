import 'package:barahi/features/utils/constants/strings.dart';
import 'package:barahi/features/utils/widgets/my_app_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dashboard.dart';
import 'widgets/image_tile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MyAppSearchField(
                    hintText: searchByFileName,
                    controller: searchController,
                    focusNode: searchFocusNode,
                    onChanged: (val) {
                      print(val);
                      if (val.isEmpty) {
                        BlocProvider.of<DashboardBloc>(context).add(ListImages());
                      } else {
                        BlocProvider.of<DashboardBloc>(context).add(SearchImage(searchText: val));
                      }
                    },
                  ),
                ),
                BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    if (state is DashboardLoaded) {
                      if (state.images.length != 0) {
                        return OrientationBuilder(builder: (context, orientation) {
                          return GridView.builder(
                              shrinkWrap: true,
                              itemCount: state.images.length,
                              physics: ClampingScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                                childAspectRatio:
                                    orientation == Orientation.portrait ? (10 / 9) : (3 / 4),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
