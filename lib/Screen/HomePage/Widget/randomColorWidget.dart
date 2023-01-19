import 'dart:math';
import 'package:flutter/material.dart';
import '../../../Helper/Color.dart';

Color generateRandomColor() {
  Random random = Random();
  // Pick a random number in the range [0.0, 1.0)
  double randomDouble = random.nextDouble();

  return Color((randomDouble * 0xFFFFFF).toInt()).withOpacity(1.0);
}

gethomePageTextDesing(
  String numberValue,
  String title,
) {
  return Column(
    children: [
      Text(numberValue,
          style: const TextStyle(
              color: black,
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontSize: 14.0),
          textAlign: TextAlign.left),
      const SizedBox(height: 10),
      Text(title,
          style: const TextStyle(
              color: Color(0xffff9366),
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontSize: 12.0),
          textAlign: TextAlign.left)
    ],
  );
}
