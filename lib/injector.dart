import 'package:cgpa_from_xlsx/src/layers/data/datasource/cgpa_datasource.dart';
import 'package:cgpa_from_xlsx/src/layers/data/repository/cgpa_repository_impl.dart';
import 'package:cgpa_from_xlsx/src/layers/domain/repository/cgpa_repository.dart';
import 'package:cgpa_from_xlsx/src/layers/domain/usecase/load_cgpa_usecase.dart';
import 'package:cgpa_from_xlsx/src/layers/presentation/cubits/cgpa_cubits.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
final _filePicker = FilePicker.platform;

void setup() {
  getIt.registerFactory<CGPACubits>(() => CGPACubits(loadCGPAUsecase: getIt()));
  getIt.registerLazySingleton<FileReadDatasource>(
      () => FileReadWithExcelDatasource(filePicker: _filePicker));
  getIt.registerLazySingleton<CGPARepository>(() => CGPARepositoryImpl(datasource: getIt()));
  getIt.registerLazySingleton<LoadCGPAUsecase>(() => LoadCGPAUsecase(repository: getIt()));
  
}
