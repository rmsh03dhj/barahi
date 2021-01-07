import 'package:equatable/equatable.dart';
import 'package:barahi/registration_or_login/data/models/user.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object> get props => [];
}

class DashboardInitialState extends DashboardState {}

class DashboardLoadedState extends DashboardState {
  final User user;

  DashboardLoadedState(this.user);
}

class DashboardLoadingState extends DashboardState {}

class DashboardErrorState extends DashboardState {}
