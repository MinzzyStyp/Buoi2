import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';

class DisplayArea extends StatelessWidget {
  const DisplayArea({super.key});

  @override
  Widget build(BuildContext context) {
    final calcProvider = Provider.of<CalculatorProvider>(context);

    return Container(
      padding: const EdgeInsets.all(24), // Đệm màn hình 24px [cite: 33]
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            calcProvider.expression.isEmpty ? '0' : calcProvider.expression,
            style: const TextStyle(fontSize: 32, color: Colors.grey, fontFamily: 'Roboto'), // [cite: 30]
          ),
          Text(
            calcProvider.result,
            style: const TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}