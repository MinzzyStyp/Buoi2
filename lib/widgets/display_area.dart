import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/history_provider.dart';

class DisplayArea extends StatelessWidget {
  const DisplayArea({super.key});

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context);
    final history = Provider.of<HistoryProvider>(context).history;

    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (history.isNotEmpty)
            Text(
              '${history[0].expression} = ${history[0].result}',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              calc.expression.isEmpty ? '0' : calc.expression,
              style: const TextStyle(fontSize: 32, color: Colors.white70),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              calc.result,
              style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}