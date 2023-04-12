import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

import 'my_text.dart';

class CircularProgressBar extends StatelessWidget {
  final double percent;
  final int? time;
  const CircularProgressBar({
    super.key,
    required this.percent,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 20,
      percent: double.parse('0.${percent.floor()}'),
      backgroundColor: Colors.black.withOpacity(0.4),
      animation: true,
      linearGradient: LinearGradient(colors: [
        Colors.purpleAccent.withOpacity(0.5),
        Colors.deepPurple,
      ]),
      animationDuration: time ?? 2000,
      center: MyText(size: 12, text: '${percent.floor()}%'),
    );
  }
}
