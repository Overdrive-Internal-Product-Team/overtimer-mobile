import 'package:flutter/material.dart';

class NewIntervalItemHeader extends StatelessWidget {
  const NewIntervalItemHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Text('Começar'),
                SizedBox(
                  width: 20,
                ),
                Text('14:55')
              ],
            ),
          ),
          Text('jan 10')
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        children: [Text('ué')],
      ),
    ]);
  }
}
