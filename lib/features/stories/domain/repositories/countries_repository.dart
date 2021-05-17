// @dart=2.9
import 'package:dartz/dartz.dart';
import 'package:rotary_nl_rye/core/error/failures.dart';

import '../../domain/entities/country.dart';

abstract class CountriesRepository {
  Future<Either<Failure, List<Country>>> getCountries();
}