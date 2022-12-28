import 'dart:io';

import 'package:cgpa_from_xlsx/src/core/error/custom_exception.dart';
import 'package:cgpa_from_xlsx/src/layers/data/model/cgpa_model.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

abstract class FileReadDatasource {
  Future<CGPAModel> getCGPA();
  Future<FilePickerResult?> _pickFile();
}

class FileReadWithExcelDatasource implements FileReadDatasource {
  const FileReadWithExcelDatasource({required this.filePicker});

  final FilePicker filePicker;
  @override
  Future<CGPAModel> getCGPA() async {
    final result = await _pickFile();
    if (result != null) {
      try {
        //var bytes = result.files.single.bytes;
        var bytes = await File(result.paths[0]!).readAsBytes();
        var excel = Excel.decodeBytes(bytes);
        final firstSheet = excel.tables.keys.first;
        num sumOfCreditUnits = 0;
        num sumOfQualityPoints = 0;
        num sumOfGradePoints = 0;
        final rowOfCourses = excel.tables[firstSheet]!.rows.sublist(1);
        for (var row in rowOfCourses) {
          sumOfCreditUnits += row[1]!.value;
          sumOfGradePoints += row[2]!.value;
          sumOfQualityPoints += (row[1]!.value * row[2]!.value);
        }
        return CGPAModel(
          cgpaScored: sumOfQualityPoints / sumOfCreditUnits,
          numberOfCourses: rowOfCourses.length,
          sumOfQualityPoints: sumOfQualityPoints,
          sumOfGradePoints: sumOfGradePoints,
          sumOfCreditUnits: sumOfCreditUnits,
        );
      } on Exception {
        throw const CustomException(
            message:
                "Kindly check for the right format of the file to be calculated");
      }
    }
    throw const CustomException(message: "No file picked/selected");
  }

  @override
  Future<FilePickerResult?> _pickFile() async {
    return await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
      allowMultiple: false,
    );
  }
}
