// @dart=2.9
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rotary_nl_rye/core/error/failures.dart';
import 'package:rotary_nl_rye/core/usecases/usecase.dart';
import 'package:rotary_nl_rye/features/stories/domain/entities/country.dart';
import 'package:rotary_nl_rye/features/stories/domain/usecases/get_countries.dart';
import 'package:rotary_nl_rye/features/stories/presentation/bloc/stories_bloc.dart';

part 'countries_event.dart';
part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  CountriesBloc({this.getCountries}) : super(Empty());

  final GetCountries getCountries;

  @override
  Stream<CountriesState> mapEventToState(
    CountriesEvent event,
  ) async* {
    if (event is BGetCountries) {
      if (state is! Loaded) {
        yield Loading();
      }
      final failureOrStories = await getCountries(NoParams());

      yield failureOrStories.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (countries) => Loaded(countries: countries));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
