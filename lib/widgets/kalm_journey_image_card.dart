import 'package:flutter/material.dart';

class KalmJourneyImageCard extends StatelessWidget {
  const KalmJourneyImageCard({
    Key? key,
    required this.journeyList,
    required this.index,
  }) : super(key: key);

  final List<Map<String, String>> journeyList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: Image.asset(
        journeyList[index]['imagePath']!,
        scale: 1.5,
      ),
    );
  }
}
