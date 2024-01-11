import 'package:flutter/material.dart';

class NewIntervalDurationInput extends StatelessWidget {
  const NewIntervalDurationInput(
      {super.key,
      required String durationMinutes,
      required String durationHours,
      required String durationSeconds});

  final String durationHours = '00';
  final String durationMinutes = '00';
  final String durationSeconds = '00';

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Row(
        children: [
          Text(
            'Duração',
          ),
        ],
      ),
      SizedBox(
        height: 15,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '00:00:00',
            style: TextStyle(fontSize: 50),
          )
        ],
      ),
      SizedBox(
        height: 30,
      ),
    ]);
  }
}
