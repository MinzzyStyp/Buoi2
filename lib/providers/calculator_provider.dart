import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../models/calculator_mode.dart';
import '../models/calculation_history.dart'; //
import 'history_provider.dart'; // Import để có thể gọi hàm lưu lịch sử

class CalculatorProvider extends ChangeNotifier {
  String _expression = '';
  String _result = '0';
  CalculatorMode _mode = CalculatorMode.basic;
  AngleMode _angleMode = AngleMode.degrees; // Mặc định là độ
  double _memory = 0;
  bool _hasMemory = false;

  // Getters 
  String get expression => _expression;
  String get result => _result;
  CalculatorMode get mode => _mode;
  bool get hasMemory => _hasMemory;

  void addToExpression(String value) {
    _expression += value;
    notifyListeners();
  }

  // Xóa ký tự cuối cùng (CE - Clear Entry) [cite: 11]
  void clearEntry() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
      notifyListeners();
    }
  }

  void clear() {
    _expression = '';
    _result = '0';
    notifyListeners();
  }

  // Chuyển đổi giữa các chế độ: Cơ bản, Khoa học, Lập trình viên [cite: 18]
  void toggleMode(CalculatorMode mode) {
    _mode = mode;
    notifyListeners();
  }

  // Thêm các hàm khoa học (sin, cos, log...)  [cite: 15, 115-120]
  void addScientificFunction(String function) {
    _expression += '$function(';
    notifyListeners();
  }

  // --- Hàm tính toán chính đã được sửa đổi ---
  // Truyền historyProvider vào để thực hiện lưu lịch sử ngay khi có kết quả
  void calculate(HistoryProvider historyProvider) {
    if (_expression.isEmpty) return;
    try {
      // 1. Chuẩn hóa & Xử lý nhân ẩn (2π -> 2*π)
      String finalExpression = _expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('π', '3.1415926535897932')
          .replaceAll('e', '2.718281828459045');

      // 2. Phân tích biểu thức PEMDAS 
      Parser p = Parser();
      Expression exp = p.parse(finalExpression);
      ContextModel cm = ContextModel();
      
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      // Định dạng kết quả tối đa 4 chữ số thập phân
      _result = eval.toStringAsFixed(eval.truncateToDouble() == eval ? 0 : 4);
      
      // --- PHẦN QUAN TRỌNG: Lưu vào lịch sử ---
      final newRecord = CalculationHistory(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Tạo ID duy nhất bằng timestamp
        expression: _expression,
        result: _result,
        timestamp: DateTime.now(),
      );
      
      historyProvider.addRecord(newRecord); //
      
    } catch (e) {
      _result = "Error"; // Phát hiện và xử lý lỗi
    }
    notifyListeners();
  }

  // --- Các hàm bộ nhớ (Memory Functions) [cite: 19] ---
  
  void memoryAdd() {
    _memory += double.tryParse(_result) ?? 0;
    _hasMemory = true;
    notifyListeners();
  }

  void memorySubtract() {
    _memory -= double.tryParse(_result) ?? 0;
    _hasMemory = true;
    notifyListeners();
  }

  void memoryRecall() {
    _expression = _memory.toString();
    _result = _memory.toString();
    notifyListeners();
  }

  void memoryClear() {
    _memory = 0;
    _hasMemory = false;
    notifyListeners();
  }
}