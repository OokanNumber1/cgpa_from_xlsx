import 'package:cgpa_from_xlsx/src/layers/domain/usecase/load_cgpa_usecase.dart';
import 'package:cgpa_from_xlsx/src/layers/presentation/cubits/cgpa_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CGPACubits extends Cubit<CGPAState> {
  CGPACubits({required LoadCGPAUsecase loadCGPAUsecase})
      : _loadCGPAUsecase = loadCGPAUsecase,
        super(LoadCGPAIdle());
  final LoadCGPAUsecase _loadCGPAUsecase;

  void loadCGPA() async {
    final param = NoParam();
    emit(LoadingCGPA());
    final response = await _loadCGPAUsecase(param);
    response.fold(
      (l) => emit(LoadCGPAFailed(message: l.toString())),
      (cgpa) => emit(LoadCGPASuccessful(cgpa: cgpa)),
    );
  }
}
