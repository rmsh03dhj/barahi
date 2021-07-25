import 'package:bloc/bloc.dart';

import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {

  DashboardBloc() : super(DashboardEmpty());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is FetchDashboardForCurrentLocation) {
      yield DashboardLoading();
    }
    if (event is FetchDashboardForGivenCity) {
      yield DashboardLoading();

    }
  }
}
