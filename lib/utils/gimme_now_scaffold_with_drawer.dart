import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barahi/app_start/presentation/bloc/app_start_bloc.dart';
import 'package:barahi/app_start/presentation/bloc/app_start_event.dart';
import 'package:barahi/core/navigation_service.dart';
import 'package:barahi/core/routes/gimme_now_routes.dart';

import '../service_locator.dart';

class GimmeNowScaffoldWithDrawer extends StatefulWidget {
  final Widget body;
  GimmeNowScaffoldWithDrawer({@required this.body});

  @override
  _GimmeNowScaffoldWithDrawerState createState() => _GimmeNowScaffoldWithDrawerState();
}

class _GimmeNowScaffoldWithDrawerState extends State<GimmeNowScaffoldWithDrawer> {
  final _navigateService = sl<NavigationService>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actionsIconTheme: IconThemeData(color: Colors.black),
          title: Text("Gimme Now"),
        ),
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              DrawerHeader(
                  child: Image.asset(
                "assets/logo.png",
                scale: 3,
              )),
              ListTile(
                title: Text("Log out"),
                onTap: () {
                  BlocProvider.of<AppStartBloc>(context).add(LoggedOut());
                  _navigateService.navigateTo(GimmeNowRoutes.signUp);
                },
              ),
            ]),
          ),
        ),
        body: widget.body);
  }
}
