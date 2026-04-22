import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../models/calculator_mode.dart';

class ModeSelector extends StatelessWidget {
  const ModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context);
    return ToggleButtons(
      isSelected: [
        provider.mode == CalculatorMode.basic,
        provider.mode == CalculatorMode.scientific,
      ],
      onPressed: (index) {
        provider.toggleMode(index == 0 ? CalculatorMode.basic : CalculatorMode.scientific);
      },
      children: const [
        Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Basic")),
        Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Scientific")),
      ],
    );
  }
}