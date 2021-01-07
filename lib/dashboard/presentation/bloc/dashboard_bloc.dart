import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barahi/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:barahi/dashboard/presentation/bloc/dashboard_state.dart';

class DashBoardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashBoardBloc() : super(DashboardInitialState());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is LoadProfile) {
      yield DashboardLoadedState(event.user);
    }
    if (event is UpdateProfile) {
      yield DashboardLoadedState(event.user);
    }
  }
}
