import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barahi/splash_screen.dart';

import 'core/routes/weather_app_routes.dart';
import 'core/services/service_locator.dart';
import 'core/services/navigation_service.dart';
import 'features/app_start/presentation/bloc/app_start_bloc.dart';
import 'features/app_start/presentation/bloc/app_start_event.dart';
import 'features/dashboard/presentation/bloc/dashboard.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';
import 'features/registration_or_login/presentation/bloc/registration_or_login.dart';
import 'features/registration_or_login/presentation/pages/register_or_login_page_wrapper.dart';

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppStartBloc>(
      create: (context) => sl<AppStartBloc>()..add(CheckForAuthentication()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RegistrationOrLoginBloc>(
            create: (context) => sl<RegistrationOrLoginBloc>(),
          ),
          BlocProvider<DashboardBloc>(
            create: (context) => sl<DashboardBloc>(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: sl<NavigationService>().navigationKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          routes: _registerRoutes(),
        ),
      ),
    );
  }
}

Map<String, WidgetBuilder> _registerRoutes() {
  return <String, WidgetBuilder>{
    MyAppRoutes.home: (context) => SplashScreen(),
    MyAppRoutes.dashboard: (context) => DashboardDashboardPage(),
    MyAppRoutes.signUpOrSignIn: (context) => _buildSignInWithEmailBloc(),
  };
}

BlocProvider<RegistrationOrLoginBloc> _buildSignInWithEmailBloc() {
  return BlocProvider<RegistrationOrLoginBloc>(
    create: (context) => sl<RegistrationOrLoginBloc>(),
    child: RegistrationOrLoginPageWrapper(),
  );
}