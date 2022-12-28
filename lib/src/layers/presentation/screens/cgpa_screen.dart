import 'package:cgpa_from_xlsx/injector.dart';
import 'package:cgpa_from_xlsx/src/layers/presentation/cubits/cgpa_cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/cgpa.dart';
import '../cubits/cgpa_states.dart';

class CGPAScreen extends StatelessWidget {
  const CGPAScreen({required this.cgpa, super.key});
  final CGPA cgpa;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final gradeColor = cgpa.cgpaScored > 4.5
        ? Colors.green
        : cgpa.cgpaScored > 3.5
            ? Colors.lightBlue
            : cgpa.cgpaScored > 2.5
                ? Colors.orange
                : Colors.brown;
    return BlocProvider<CGPACubits>(
      create: (context) => getIt(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    gradeColor.shade200,
                    Colors.grey.shade200,
                    gradeColor.shade50,
                    Colors.grey.shade200,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                        text: cgpa.cgpaScored.toString().substring(0, 4),
                        style: const TextStyle(fontSize: 40),
                        children: const [
                          TextSpan(text: "cgpa", style: TextStyle(fontSize: 12))
                        ]),
                  ),
                  Text("Total Course Offered : ${cgpa.numberOfCourses}"),
                  Text("Total Credit Unit : ${cgpa.sumOfCreditUnits}"),
                  Text("Total Grade Point : ${cgpa.sumOfGradePoints}"),
                  Text("Total Quality Point : ${cgpa.sumOfQualityPoints}"),
                  const SizedBox(height: 32),
                  BlocConsumer<CGPACubits, CGPAState>(
                    listener: (context, state) {
                      if (state is LoadCGPASuccessful) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CGPAScreen(cgpa: state.cgpa),
                          ),
                        );
                      } else if (state is LoadCGPAFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              "Kindly follow the header format.",
                              //state.message
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.blue.shade700,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Row(
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: ButtonStyle(
                              fixedSize: MaterialStatePropertyAll(
                                Size(screenSize.width * 0.36, 44),
                              ),
                            ),
                            child: Text(
                              "Go Back",
                              style: TextStyle(color: Colors.blue.shade900),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () =>
                                context.read<CGPACubits>().loadCGPA(),
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(screenSize.width * 0.48, 44),
                                backgroundColor: Colors.blue.shade900),
                            child: const Text("Pick Another Sheet"),
                          )
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
