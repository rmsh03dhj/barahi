import 'package:barahi/core/routes/weather_app_routes.dart';
import 'package:barahi/features/dashboard/presentation/bloc/dashboard.dart';
import 'package:barahi/features/dashboard/presentation/pages/widgets/image_viewer.dart';
import 'package:barahi/features/utils/constants/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:barahi/core/services/navigation_service.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'dashboard.dart';
import 'shared.dart';
import 'widgets/side_drawer.dart';

class DashboardDashboardPage extends StatefulWidget {
  final User user;

  const DashboardDashboardPage({Key key, this.user}) : super(key: key);

  @override
  _DashboardDashboardPageState createState() => _DashboardDashboardPageState();
}

class _DashboardDashboardPageState extends State<DashboardDashboardPage> {
  final navigationService = sl<NavigationService>();
  final _picker = ImagePicker();

  int currentTab = 0;

  final List<Widget> screens = [
    Home(),
    SharedImages(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
                style: TextStyle(
                  color: Theme.of(context).disabledColor,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ),
      drawer: SideDrawer(),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt_outlined),
        onPressed: () {
          showOptionsDialog(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        BlocProvider.of<DashboardBloc>(context).add(ListImages());
                        currentScreen = Home();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.home,
                            color: currentTab == 0 ? Colors.tealAccent : Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                          child: Text(
                            home,
                            style: TextStyle(
                              color: currentTab == 0 ? Colors.tealAccent : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        BlocProvider.of<DashboardBloc>(context).add(ListSharedImages());
                        currentScreen = SharedImages();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.people,
                                color: currentTab == 2 ? Colors.tealAccent : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                          child: Text(
                            shared,
                            style: TextStyle(
                              color: currentTab == 2 ? Colors.tealAccent : Colors.grey,
                            ),
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
      ),
    );
  }

  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Options"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Capture Image From Camera"),
                    onTap: () {
                      openCamera();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Take Image From Gallery"),
                    onTap: () {
                      openGallery();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void openCamera() async {
    var imgCamera = await _picker.getImage(source: ImageSource.camera);
    Navigator.of(context).pop();
    sl<NavigationService>().navigateTo(MyAppRoutes.imageViewer,
        arguments: ImageViewerInput(localImage: imgCamera.path));
  }

  void openGallery() async {
    var imgGallery = await _picker.getImage(source: ImageSource.gallery);
    Navigator.of(context).pop();
    sl<NavigationService>().navigateTo(MyAppRoutes.imageViewer,
        arguments: ImageViewerInput(localImage: imgGallery.path));
  }
}
