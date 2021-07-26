import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/routes/weather_app_routes.dart';
import 'core/services/service_locator.dart';
import 'core/services/navigation_service.dart';
import 'features/app_start/presentation/bloc/app_start_bloc.dart';
import 'features/app_start/presentation/bloc/app_start_state.dart';
import 'features/dashboard/presentation/bloc/dashboard.dart';
import 'features/utils/constants/strings.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final navigator = sl<NavigationService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppStartBloc, AppStartState>(
      listener: (context, state) {
        if (state is Unauthenticated || state is Uninitialized) {
          Timer(
            Duration(seconds: 5),
            () => navigator.navigateToAndReplace(MyAppRoutes.signUpOrSignIn),
          );
        }
        if (state is Authenticated) {
          Timer(Duration(seconds: 5), () async {
            BlocProvider.of<DashboardBloc>(context)..add(ListImages(listImagesFrom: UPLOAD_IN));
            navigator.navigateToAndRemoveUntil(MyAppRoutes.dashboard);
          });
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150,
              ),
              Text(
                MyApp.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5,
                  fontSize: 25,
                ),
              ),
              Container(
                height: 100,
              ),
              Image.asset(
                "assets/launcher_icon.jpg",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
