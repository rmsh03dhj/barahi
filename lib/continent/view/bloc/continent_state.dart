part of 'continent_bloc.dart';

abstract class ContinentState extends Equatable {
  const ContinentState();

  @override
  List<Object> get props => [];
}

class ContinentInitial extends ContinentState {}

class ContinentLoading extends ContinentState {}

class ContinentLoaded extends ContinentState {
  final List continents;
  const ContinentLoaded(this.continents);
}

class ContinentError extends ContinentState {
  final String errorMessage;

  const ContinentError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
