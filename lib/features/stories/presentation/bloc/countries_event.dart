// @dart=2.9
part of 'countries_bloc.dart';

abstract class CountriesEvent extends Equatable {
  const CountriesEvent();

  @override
  List<Object> get props => [];
}

class BGetCountries extends CountriesEvent {}
