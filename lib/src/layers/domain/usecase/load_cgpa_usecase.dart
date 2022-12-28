import 'package:cgpa_from_xlsx/src/layers/domain/entity/cgpa.dart';
import 'package:cgpa_from_xlsx/src/layers/domain/repository/cgpa_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:cgpa_from_xlsx/src/core/error/failure.dart';
import '../../../core/usecase/usecase.dart';

class LoadCGPAUsecase extends Usecase<CGPA,NoParam>{
   LoadCGPAUsecase({required this.repository});
  final CGPARepository repository;
  @override
  Future<Either<Failure, CGPA>> call(params) async{
    return await repository.getCGPA();
  }
}

class NoParam{}