import 'package:cgpa_from_xlsx/src/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Usecase<R, P> {
  Future<Either<Failure, R>> call(P params);
}

class NoParam extends Equatable{
  @override
  List get props => [];
}
