import 'package:flutter/material.dart';
import '../widgets/display_area.dart';
import '../widgets/button_grid.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E), // Màu Primary Light [cite: 28]
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(flex: 2, child: DisplayArea()), // Vùng hiển thị [cite: 87]
            const Expanded(flex: 3, child: ButtonGrid()),  // Lưới nút bấm [cite: 98]
          ],
        ),
      ),
    );
  }
}