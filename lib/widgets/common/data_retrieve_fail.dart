import 'package:flutter/material.dart';

class DataRetrieveFail extends StatelessWidget {
  final VoidCallback onRetry;

  const DataRetrieveFail({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Erro ao carregar dados:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Tentar Novamente'),
          ),
        ],
      ),
    );
  }
}
