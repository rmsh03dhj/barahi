part of 'continent_bloc.dart';

abstract class ContinentEvent extends Equatable {
  const ContinentEvent();

  @override
  List<Object> get props => [];
}

class GetContinents extends ContinentEvent {
  GetContinents();
}
