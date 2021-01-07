import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barahi/amplifyconfiguration.dart';
import 'package:barahi/registration_or_login/presentation/bloc/registration_or_login_bloc.dart';
import 'package:barahi/registration_or_login/presentation/pages/confirmation_code_entry_page.dart';
import 'package:barahi/registration_or_login/presentation/pages/register_or_login_page_wrapper.dart';
import 'package:barahi/service_locator.dart';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:barahi/splash_screen.dart';

import 'app_start/presentation/bloc/app_start_bloc.dart';
import 'app_start/presentation/bloc/app_start_event.dart';
import 'core/navigation_service.dart';
import 'core/routes/gimme_now_routes.dart';
import 'dashboard/presentation/bloc/dashboard_bloc.dart';
import 'dashboard/presentation/pages/dashboard_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Amplify amplifyInstance = Amplify();

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    try {
      AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
      amplifyInstance.addPlugin(authPlugins: [authPlugin]);
      await amplifyInstance.configure(amplifyconfig);
      print("configured");
    } catch (e) {
      print(e);
    }
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
          BlocProvider<DashBoardBloc>(
            create: (context) => sl<DashBoardBloc>(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: sl<NavigationService>().navigationKey,
          debugShowCheckedModeBanner: false,
          routes: _registerRoutes(),
          onGenerateRoute: _registerRoutesWithParameters,
        ),
      ),
    );
  }
}

Map<String, WidgetBuilder> _registerRoutes() {
  return <String, WidgetBuilder>{
    GimmeNowRoutes.signUp: (context) => _buildRegistrationOrLoginBloc(),
    GimmeNowRoutes.home: (context) => SplashScreen(),
  };
}

BlocProvider<RegistrationOrLoginBloc> _buildRegistrationOrLoginBloc() {
  return BlocProvider<RegistrationOrLoginBloc>(
    create: (context) => sl<RegistrationOrLoginBloc>(),
    child: RegistrationOrLoginPageWrapper(),
  );
}

Route _registerRoutesWithParameters(RouteSettings settings) {
  if (settings.name == GimmeNowRoutes.code) {
    final user = settings.arguments;
    return MaterialPageRoute(
      settings: RouteSettings(
        name: GimmeNowRoutes.code,
      ),
      builder: (context) {
        return ConfirmCodeEntryPageWrapper(user);
      },
    );
  }
  if (settings.name == GimmeNowRoutes.dashboard) {
    final email = settings.arguments;
    return MaterialPageRoute(
      settings: RouteSettings(
        name: GimmeNowRoutes.dashboard,
      ),
      builder: (context) {
        return DashBoardPageWrapper(email);
      },
    );
  } else {
    return MaterialPageRoute(
      builder: (context) {
        return RegistrationOrLoginPageWrapper();
      },
    );
  }
}
