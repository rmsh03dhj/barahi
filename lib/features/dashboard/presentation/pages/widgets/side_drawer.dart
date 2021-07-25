import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barahi/core/routes/weather_app_routes.dart';
import 'package:barahi/core/services/navigation_service.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/features/app_start/presentation/bloc/app_start_bloc.dart';
import 'package:barahi/features/app_start/presentation/bloc/app_start_event.dart';
import 'package:barahi/features/utils/constants/strings.dart';


class SideDrawer extends StatelessWidget {

  SideDrawer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Container(
                  height: 72,
                  width: 72,
                  child: Image.asset(
                    "assets/login_icon.png",
                    scale: 3,
                  ),
                ),
                Container(
                  height: 24,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Welcome",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Container(
                  height: 4,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Test",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(logoutText),
            leading: Icon(Icons.logout),
            onTap: () {
              BlocProvider.of<AppStartBloc>(context)..add(LoggedOut());
              sl<NavigationService>().navigateToAndRemoveUntil(MyAppRoutes.signUpOrSignIn);
            },
          ),
        ]),
      ),
    );
  }
}
