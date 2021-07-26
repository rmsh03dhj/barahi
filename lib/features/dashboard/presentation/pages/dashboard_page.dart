import 'dart:io';

import 'package:barahi/features/dashboard/presentation/bloc/dashboard.dart';
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
  TextEditingController cityNameController = TextEditingController();
  FocusNode cityNameFocusNode = FocusNode();
  File imgFile;
  final _picker = ImagePicker();


  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Dashboard(),
    Shared(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard(); // Our first view in viewport

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
                  style: TextStyle(color: Theme.of(context).disabledColor, fontSize: 14),
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
    child: Icon(Icons.add),
    onPressed: () {
      showOptionsDialog(context);
    },
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    bottomNavigationBar: BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 10,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen =
                          Dashboard(); // if user taps on this dashboard tab will be active
                      currentTab = 0;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.dashboard,
                        color: currentTab == 0 ? Colors.blue : Colors.grey,
                      ),
                      Text(
                        'Dashboard',
                        style: TextStyle(
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Right Tab bar icons

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen =
                          Shared(); // if user taps on this dashboard tab will be active
                      currentTab = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.dashboard,
                        color: currentTab == 2 ? Colors.blue : Colors.grey,
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
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
    setState(() {
      imgFile = File(imgCamera.path);
    });
    Navigator.of(context).pop();
  }

  void openGallery() async {
    var imgGallery = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      imgFile = File(imgGallery.path);
    });
    Navigator.of(context).pop();
  }

  void uploadPicture(File imgFile) {
    BlocProvider.of<DashboardBloc>(context).add(UploadImage(imgFile));
  }
  Widget displayImage(){
    if(imgFile == null){
      return Text("No Image Selected!");
    } else{
      return Image.file(imgFile, width: 350, height: 350);
    }
  }
}
