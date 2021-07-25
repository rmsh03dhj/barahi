import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:barahi/core/routes/weather_app_routes.dart';
import 'package:barahi/core/services/navigation_service.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/features/app_start/presentation/bloc/app_start_bloc.dart';
import 'package:barahi/features/app_start/presentation/bloc/app_start_event.dart';
import 'package:barahi/features/dashboard/presentation/bloc/dashboard.dart';
import 'package:barahi/features/utils/constants/strings.dart';
import 'package:barahi/features/utils/widgets/my_app_button.dart';
import 'package:barahi/features/utils/widgets/my_app_form_builder_text_field.dart';

import 'bottom_bar.dart';
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
    onPressed: () {},
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    bottomNavigationBar: BottomBar(),
    );
  }

  void _showCityChangeDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                changeCityText,
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                child: MyAppButton(
                  text: okButtonText,
                  onPressed: () {
                    if (cityNameController.text.isEmpty) {
                      BlocProvider.of<DashboardBloc>(context)..add(FetchDashboardForCurrentLocation());
                    } else {
                      BlocProvider.of<DashboardBloc>(context)
                        ..add(FetchDashboardForGivenCity(cityName: cityNameController.text));
                      FocusScope.of(context).unfocus();
                    }
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
            content: MyAppFormBuilderTextField(
              attribute: cityNameText,
              label: cityNameText,
              controller: cityNameController,
            ),
          );
        });
  }
}
