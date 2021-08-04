import 'package:barahi/core/routes/my_app_routes.dart';
import 'package:barahi/core/services/navigation_service.dart';
import 'package:barahi/features/dashboard/presentation/bloc/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barahi/core/services/service_locator.dart';
import 'package:barahi/features/app_start/presentation/bloc/app_start_bloc.dart';
import 'package:barahi/features/app_start/presentation/bloc/app_start_event.dart';
import 'package:barahi/features/utils/constants/strings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                    "assets/launcher_icon.jpg",
                    scale: 5,
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
              ],
            ),
          ),
          ListTile(
            title: Text(fileName),
            leading: Icon(FontAwesomeIcons.sortAlphaDown),
            onTap: () {
              BlocProvider.of<DashboardBloc>(context)..add(SortByFileName());
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(fileName),
            leading: Icon(FontAwesomeIcons.sortAlphaDownAlt),
            onTap: () {
              BlocProvider.of<DashboardBloc>(context)..add(SortByFileName(ascending: false));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(uploadedAt),
            leading: Icon(FontAwesomeIcons.sortNumericDown),
            onTap: () {
              BlocProvider.of<DashboardBloc>(context)..add(SortByUploadedDate());
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(uploadedAt),
            leading: Icon(FontAwesomeIcons.sortNumericDownAlt),
            onTap: () {
              BlocProvider.of<DashboardBloc>(context)..add(SortByUploadedDate(ascending: false));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(myFav),
            leading: Icon(FontAwesomeIcons.sortDown),
            onTap: () {
              BlocProvider.of<DashboardBloc>(context)..add(SortByMyFav());
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(myFav),
            leading: Icon(FontAwesomeIcons.sortUp),
            onTap: () {
              BlocProvider.of<DashboardBloc>(context)..add(SortByMyFav(ascending: false));
              Navigator.pop(context);
            },
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
