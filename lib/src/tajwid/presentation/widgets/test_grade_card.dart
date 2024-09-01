import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class TestGradeCard extends StatelessWidget {
  const TestGradeCard({
    required this.grade,
    super.key,
  });

  final double grade;

  String get formattedGrade => grade.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16).copyWith(bottom: 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colours.grey50,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colours.grey700.withOpacity(0.45),
            blurRadius: 2,
            spreadRadius: 1,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              formattedGrade,
              style: Typographies.medium23,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: RatingStars(
              value: grade,
              maxValue: 100,
              starCount: 10,
              starSpacing: 4,
              starColor: Colors.orange,
              valueLabelVisibility: false,
              maxValueVisibility: false,
            ),
          ),
        ],
      ),
    );
  }
}
