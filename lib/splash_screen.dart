import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barahi/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:barahi/registration_or_login/data/models/user.dart';

import 'app_start/presentation/bloc/app_start_bloc.dart';
import 'app_start/presentation/bloc/app_start_state.dart';
import 'core/navigation_service.dart';
import 'core/routes/gimme_now_routes.dart';
import 'core/service_locator.dart';
import 'dashboard/presentation/bloc/dashboard_event.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _navigator = sl<NavigationService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppStartBloc, AppStartState>(
      listener: (context, state) {
        if (state is Uninitialized || state is Unauthenticated) {
          Timer(
            Duration(seconds: 2),
            () => _navigator.navigateToAndReplace(GimmeNowRoutes.signUp),
          );
        }
        if (state is Authenticated) {
          Timer(Duration(seconds: 2), () {
            BlocProvider.of<DashBoardBloc>(context)
                .add(LoadProfile(User(firstName: "Ram", lastName: "Dhj")));
            _navigator.navigateTo(GimmeNowRoutes.dashboard);
          });
        }
      },
      child: Scaffold(
        body: Center(
          child: Hero(
            tag: "logo",
            child: Image.asset(
              "assets/logo_small.png",
              scale: 4,
            ),
          ),
        ),
      ),
    );
  }
}
