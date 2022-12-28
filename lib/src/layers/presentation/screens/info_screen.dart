import 'package:cgpa_from_xlsx/src/layers/presentation/cubits/cgpa_states.dart';
import 'package:cgpa_from_xlsx/src/layers/presentation/screens/cgpa_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injector.dart';
import '../cubits/cgpa_cubits.dart';
import 'widget/info_slide.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final slideContent = const [
    InfoSlideContent(
        description:
            "Header(first row) of spreadsheet to be loaded must be in the following format:\nCourse Code | Credit Unit | Grade Point",
        example: "assets/shots/header.png",
        header: "Spreadsheet Header Format"),
    InfoSlideContent(
      header: "5-Points Grade System",
      example: "assets/shots/five_point_example.png",
      description:
          "The following are the points for grades in a 5 point system (Grade column is just for example sake): \n\nA - 5 \nB - 4\nC - 3 \nD - 2\nE - 1 \nF - 0",
    ),
    InfoSlideContent(
      description:
          "The following are the points for grades in a 4 point system (Grade column is just for example sake):\n\nA - 4  \nB - 3\nC - 2\nD - 1\nF - 0",
      example: "assets/shots/four_point_example.png",
      header: "4-Points Grade System",
    ),
  ];

  late final PageController controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocProvider<CGPACubits>(
      create: (context) => getIt(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.fromBorderSide(BorderSide.none)),
                    height: screenSize.height * 0.56,
                    child: PageView(
                      controller: controller,
                      onPageChanged: (value) => setState(() {
                        currentIndex = value;
                      }),
                      children: List.generate(
                        slideContent.length,
                        (index) => InfoSlide(
                          gradient: index == 0
                              ? Colors.lightBlue[100]!
                              : index == 1
                                  ? Colors.purple[100]!
                                  : Colors.indigo[100]!,
                          header: slideContent[index].header,
                          description: slideContent[index].description,
                          example: slideContent[index].example,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        height: currentIndex == index ? 16 : 8,
                        width: currentIndex == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? Colors.blue.shade900
                              : Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.08),
                  BlocConsumer<CGPACubits, CGPAState>(
                    listener: (context, state) {
                      if (state is LoadCGPASuccessful) {
                        Navigator.push(
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
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.blue.shade700,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return TextButton(
                        onPressed: () => context.read<CGPACubits>().loadCGPA(),
                        style: ButtonStyle(
                          padding: const MaterialStatePropertyAll(
                            EdgeInsets.only(bottom: 2),
                          ),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blue.shade900),
                          fixedSize: const MaterialStatePropertyAll(
                            Size(double.maxFinite, 44),
                          ),
                        ),
                        child: const Text(
                          "Pick Sheet",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
