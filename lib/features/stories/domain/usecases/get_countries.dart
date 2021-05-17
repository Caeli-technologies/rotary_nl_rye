// @dart=2.9
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/country.dart';
import '../repositories/countries_repository.dart';

class GetCountries implements UseCase<List<Country>, NoParams> {
  final CountriesRepository repository;

  GetCountries(this.repository);

  @override
  Future<Either<Failure, List<Country>>> call(NoParams params) async {
    return await repository.getCountries();
  }
}
