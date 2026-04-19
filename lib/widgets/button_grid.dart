import 'package:flutter/material.dart';
import 'calculator_button.dart';

class ButtonGrid extends StatelessWidget {
  const ButtonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> buttons = [
      'C', 'CE', '%', '÷',
      '7', '8', '9', '×',
      '4', '5', '6', '-',
      '1', '2', '3', '+',
      '±', '0', '.', '=',
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(12), // Khoảng cách 12px [cite: 31]
      itemCount: buttons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, index) => CalculatorButton(label: buttons[index]),
    );
  }
}