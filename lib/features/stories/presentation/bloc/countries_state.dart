// @dart=2.9
part of 'countries_bloc.dart';

abstract class CountriesState extends Equatable {
  const CountriesState();
}

class Empty extends CountriesState {
  @override
  List<Object> get props => [];
}

class Loading extends CountriesState {
  @override
  List<Object> get props => [];
}

class Loaded extends CountriesState {
  final List<Country> countries;

  Loaded({this.countries});

  @override
  List<Object> get props => [countries];
}

class Error extends CountriesState {
  final String message;

  // TODO log errors

  Error({this.message});

  @override
  List<Object> get props => [message];
}
