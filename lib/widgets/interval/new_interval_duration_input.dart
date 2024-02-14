import 'package:flutter/material.dart';

class NewIntervalDurationInput extends StatefulWidget {
  const NewIntervalDurationInput(
      {super.key,
      required this.onSaveDuration,
      required this.currentHoursDuration,
      required this.currentMinutesDuration});

  final String currentHoursDuration;
  final String currentMinutesDuration;
  final void Function(String hours, String minutes) onSaveDuration;

  @override
  State<NewIntervalDurationInput> createState() =>
      _NewIntervalDurationInputState();
}

class _NewIntervalDurationInputState extends State<NewIntervalDurationInput> {
  final _hoursController = TextEditingController(text: '00');
  final _minutesController = TextEditingController(text: '00');

  void _openAddDurationOverlay(BuildContext context) {
    _hoursController.text = widget.currentHoursDuration;
    _hoursController.text = widget.currentMinutesDuration;

    showDialog(
      useSafeArea: true,
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Insira a duração'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: _hoursController,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 40),
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: false),
              ),
            ),
            const Text(
              '',
              style: TextStyle(fontSize: 40),
            ),
            Expanded(
              child: TextField(
                controller: _minutesController,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 40),
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: false),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Ok'),
            onPressed: () {
              widget.onSaveDuration(
                  _hoursController.text, _minutesController.text);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Row(
        children: [
          Text(
            'Duração',
          ),
        ],
      ),
      const SizedBox(
        height: 15,
      ),
      GestureDetector(
        onTap: () {
          _openAddDurationOverlay(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${widget.currentHoursDuration}:${widget.currentMinutesDuration}',
              style: const TextStyle(fontSize: 50),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 30,
      ),
    ]);
  }
}
