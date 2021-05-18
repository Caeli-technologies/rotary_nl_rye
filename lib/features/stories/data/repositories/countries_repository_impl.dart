// @dart=2.9
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/country.dart';
import '../../domain/repositories/countries_repository.dart';
import '../datasources/countries_remote_data_source.dart';

class CountriesRepositoryImpl implements CountriesRepository {
  final CountriesRemoteDataSource countriesRemoteDataSource;

  CountriesRepositoryImpl({@required this.countriesRemoteDataSource});

  @override
  Future<Either<Failure, List<Country>>> getCountries() async {
    try {
      print("Fetch data");
      final data = await countriesRemoteDataSource.getCountries();
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
