import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class Failure extends Equatable {
  final String failureMessage;

  Failure(this.failureMessage);

  @override
  List<Object> get props => [];
}

class GeneralFailure extends Failure {
  GeneralFailure({required String failureMessage}) : super(failureMessage);
}

class HttpFailure extends Failure {
  HttpFailure({required String failureMessage}) : super(failureMessage);
}
