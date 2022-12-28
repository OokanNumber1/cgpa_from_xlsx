import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class FileFailure extends Failure {
  FileFailure(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
