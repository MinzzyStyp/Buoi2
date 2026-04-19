import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';

class CalculatorButton extends StatelessWidget {
  final String label;
  const CalculatorButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final calcProvider = Provider.of<CalculatorProvider>(context, listen: false);

    return Material(
      color: _getBtnColor(),
      borderRadius: BorderRadius.circular(16), // Bo góc 16px [cite: 32]
      child: InkWell(
        onTap: () => _handlePress(calcProvider),
        borderRadius: BorderRadius.circular(16),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold), // [cite: 30]
          ),
        ),
      ),
    );
  }

  Color _getBtnColor() {
    if (['=', '÷', '×', '-', '+'].contains(label)) return const Color(0xFFFF6B6B); // Accent [cite: 28]
    return const Color(0xFF424242); // Secondary [cite: 28]
  }

  void _handlePress(CalculatorProvider p) {
    if (label == 'C') p.clear();
    else p.addToExpression(label);
  }
}