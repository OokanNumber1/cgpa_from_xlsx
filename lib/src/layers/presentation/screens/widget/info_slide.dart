import 'dart:ui';

import 'package:flutter/material.dart';

class InfoSlide extends StatelessWidget {
  const InfoSlide({
    required this.header,
    required this.description,
    required this.gradient,
    required this.example,
    super.key,
  });
  final String header;
  final String description;
  final String example;
  final Color gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Colors.grey.shade200,
            gradient,
            Colors.grey.shade200,
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            header,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 32),
          ),
          Text(description),
          const SizedBox(height: 32),
          Image.asset(example)
        ],
      ),
    );
  }
}

class InfoSlideContent {
  const InfoSlideContent({
    required this.description,
    required this.example,
    required this.header,
  });
  final String header;
  final String description;
  final String example;
}
