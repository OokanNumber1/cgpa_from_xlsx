import 'package:equatable/equatable.dart';

import '../../domain/entity/cgpa.dart';

abstract class CGPAState extends Equatable {
  @override
  List get props => [];
}

class LoadCGPAIdle extends CGPAState{}

class LoadingCGPA extends CGPAState {}

class LoadCGPASuccessful extends CGPAState {
  LoadCGPASuccessful({required this.cgpa});
  final CGPA cgpa;
}

class LoadCGPAFailed extends CGPAState {
  LoadCGPAFailed({required this.message});
  final String message;
}
