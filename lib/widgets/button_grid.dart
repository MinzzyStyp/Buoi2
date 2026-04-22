import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../models/calculator_mode.dart';
import 'calculator_button.dart';

class ButtonGrid extends StatelessWidget {
  const ButtonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final calcProvider = Provider.of<CalculatorProvider>(context);
    final isScientific = calcProvider.mode == CalculatorMode.scientific;

    final List<String> scientificButtons = [
      '2nd', 'sin', 'cos', 'tan', 'Ln', 'log',
      'x²', '√', 'x^y', '(', ')', '÷',
      'MC', '7', '8', '9', 'C', '×',
      'MR', '4', '5', '6', 'CE', '-',
      'M+', '1', '2', '3', '%', '+',
      'M-', '±', '0', '.', 'π', '=',
    ];

    final List<String> basicButtons = [
      'C', 'CE', '%', '÷',
      '7', '8', '9', '×',
      '4', '5', '6', '-',
      '1', '2', '3', '+',
      '±', '0', '.', '=',
    ];

    return Align(
      alignment: Alignment.bottomCenter,
      child: GridView.builder(
        shrinkWrap: true, 
        physics: const NeverScrollableScrollPhysics(), 
        padding: const EdgeInsets.all(16), 
        itemCount: isScientific ? scientificButtons.length : basicButtons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isScientific ? 6 : 4,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: isScientific ? 0.85 : 1.2,
        ),
        itemBuilder: (context, index) => CalculatorButton(
          label: isScientific ? scientificButtons[index] : basicButtons[index],
        ),
      ),
    );
  }
}