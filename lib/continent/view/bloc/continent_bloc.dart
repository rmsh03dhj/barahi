import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:barahi/service_locator.dart';
import 'package:injectable/injectable.dart';

import '../../data/get_continents_use_case.dart';

part 'continent_event.dart';
part 'continent_state.dart';

@injectable
class ContinentBloc extends Bloc<ContinentEvent, ContinentState> {
  final getContinentsUseCase = sl<GetContinentsUseCase>();

  ContinentBloc() : super(ContinentInitial());

  @override
  Stream<ContinentState> mapEventToState(
    ContinentEvent event,
  ) async* {
    if (event is GetContinents) {
      yield ContinentLoading();
      final failureOrresult = await getContinentsUseCase.execute(NoParams());
      yield failureOrresult.fold((failure) => ContinentError(""),
          (continents) => ContinentLoaded(continents));
    }
  }
}
