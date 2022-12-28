import 'package:cgpa_from_xlsx/src/layers/domain/entity/cgpa.dart';

class CGPAModel extends CGPA {
  const CGPAModel({
    required super.numberOfCourses,
    required super.sumOfCreditUnits,
    required super.sumOfGradePoints,
    required super.sumOfQualityPoints,
    required super.cgpaScored,
  });

  @override
  String toString() {
    return 'CGPA(numberOfCourses: $numberOfCourses, sumOfGradePoints: $sumOfGradePoints, sumOfCreditUnits: $sumOfCreditUnits, sumOfQualityPoints: $sumOfQualityPoints, cgpaScored: $cgpaScored)';
  }
}
