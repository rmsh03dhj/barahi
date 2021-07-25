import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDashboardForCurrentLocation extends DashboardEvent {
  FetchDashboardForCurrentLocation();

  @override
  String toString() => 'FetchDashboardForCurrentLocation';
}

class FetchDashboardForGivenCity extends DashboardEvent {
  final String cityName;

  FetchDashboardForGivenCity({@required this.cityName});

  @override
  String toString() => 'FetchDashboardForGivenCity';
}
