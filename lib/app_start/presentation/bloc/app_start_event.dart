import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AppStartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckForAuthentication extends AppStartEvent {
  @override
  String toString() => 'CheckForAuthentication';
}

class LoggedIn extends AppStartEvent {
  @override
  String toString() => 'LoggedIn';
}

class LoggedOut extends AppStartEvent {
  @override
  String toString() => 'LoggedOut';
}
