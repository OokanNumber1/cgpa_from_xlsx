import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../entity/cgpa.dart';

abstract class CGPARepository {
  Future<Either<Failure,CGPA>> getCGPA();
}