import 'package:cgpa_from_xlsx/src/core/error/custom_exception.dart';
import 'package:cgpa_from_xlsx/src/layers/data/datasource/cgpa_datasource.dart';
import 'package:cgpa_from_xlsx/src/layers/data/model/cgpa_model.dart';
import 'package:cgpa_from_xlsx/src/layers/domain/repository/cgpa_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';

class CGPARepositoryImpl implements CGPARepository {
  const CGPARepositoryImpl({required this.datasource});
  final FileReadDatasource datasource;
  @override
  Future<Either<Failure, CGPAModel>> getCGPA() async {
    try {
      final cgpa = await datasource.getCGPA();
      return Right(cgpa);
    } on CustomException catch (err) {
      return Left(FileFailure(err.message));
    } catch (error) {
      return Left(
        FileFailure(error.toString()),
      );
    }
  }
}
