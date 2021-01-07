import 'package:equatable/equatable.dart';
import 'package:barahi/registration_or_login/data/models/user.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProfile extends DashboardEvent {
  final User user;

  LoadProfile(this.user);
}

class UpdateProfile extends DashboardEvent {
  final User user;

  UpdateProfile(this.user);
}
