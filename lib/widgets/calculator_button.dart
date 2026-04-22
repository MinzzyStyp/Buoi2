import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../providers/calculator_provider.dart';
import '../providers/history_provider.dart';

class CalculatorButton extends StatefulWidget {
  final String label;
  const CalculatorButton({super.key, required this.label});

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  double _scale = 1.0;

  void _confirmClear(BuildContext context, HistoryProvider history) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xóa lịch sử?'),
        content: const Text('Tất cả lịch sử sẽ bị xóa sạch.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
          TextButton(
            onPressed: () {
              history.clearAllHistory();
              Navigator.pop(ctx);
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context, listen: false);
    final history = Provider.of<HistoryProvider>(context, listen: false);

    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.9),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      // Nhấn giữ nút C để xóa toàn bộ lịch sử
      onLongPress: widget.label == 'C' ? () => _confirmClear(context, history) : null,
      onTap: () {
        HapticFeedback.lightImpact();
        if (widget.label == '=') {
          calc.calculate(history);
        } else if (widget.label == 'C') {
          calc.clear();
        } else if (widget.label == 'CE') {
          calc.clearEntry();
        } else {
          calc.addToExpression(widget.label);
        }
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            color: _getBtnColor(context, widget.label),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              widget.label,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Color _getBtnColor(BuildContext context, String label) {
    if (label == '=') return Theme.of(context).colorScheme.surface;
    if (['C', 'CE', '÷', '×', '-', '+', '%'].contains(label)) {
      return Theme.of(context).colorScheme.secondary.withOpacity(0.3);
    }
    return Colors.grey[900]!;
  }
}