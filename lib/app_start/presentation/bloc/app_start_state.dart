import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AppStartState extends Equatable {
  @override
  List<Object> get props => [];
}

class Uninitialized extends AppStartState {
  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AppStartState {
  Authenticated();
  @override
  String toString() => 'Authenticated';
}

class Unauthenticated extends AppStartState {
  @override
  String toString() => 'Unauthenticated';
}
