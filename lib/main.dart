import 'package:barahi/core/services/service_locator.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/simple_bloc_delegate.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocDelegate();
  runApp(MyApp());
}
