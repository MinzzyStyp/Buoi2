import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../models/calculator_mode.dart';
import '../models/calculation_history.dart';
import 'history_provider.dart';

class CalculatorProvider extends ChangeNotifier {
  String _expression = '';
  String _result = '0';
  CalculatorMode _mode = CalculatorMode.basic;
  AngleMode _angleMode = AngleMode.degrees; 
  int _decimalPrecision = 2; 
  double _memory = 0;
  bool _hasMemory = false;

  String get expression => _expression;
  String get result => _result;
  CalculatorMode get mode => _mode;
  AngleMode get angleMode => _angleMode;
  bool get hasMemory => _hasMemory;

  void addToExpression(String value) {
    _expression += value;
    notifyListeners();
  }

  void clear() {
    _expression = '';
    _result = '0';
    notifyListeners();
  }

  void clearEntry() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
      notifyListeners();
    }
  }

  void toggleSign() {
    if (_result != '0' && _result != 'Error') {
      if (_result.startsWith('-')) {
        _result = _result.substring(1);
      } else {
        _result = '-$_result';
      }
      _expression = _result;
      notifyListeners();
    }
  }

  void toggleMode(CalculatorMode mode) {
    _mode = mode;
    notifyListeners();
  }

  void toggleAngleMode() {
    _angleMode = _angleMode == AngleMode.degrees ? AngleMode.radians : AngleMode.degrees;
    notifyListeners();
  }

  void addScientificFunction(String function) {
    _expression += '$function(';
    notifyListeners();
  }

  String get binaryResult => int.tryParse(_result)?.toRadixString(2) ?? '0';
  String get hexResult => int.tryParse(_result)?.toRadixString(16).toUpperCase() ?? '0';
  String get octalResult => int.tryParse(_result)?.toRadixString(8) ?? '0';

  void performBitwise(String op) {
    int val = int.tryParse(_result) ?? 0;
    switch (op) {
      case 'NOT':
        _result = (~val).toString();
        _expression = 'NOT($val)';
        break;
      case 'AND':
      case 'OR':
      case 'XOR':
      case '<<':
      case '>>':
        _expression = '$val $op ';
        break;
    }
    notifyListeners();
  }

  void calculate(HistoryProvider historyProvider) {
    if (_expression.isEmpty) return;
    try {
      String finalExpr = _expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('π', '3.1415926535897932')
          .replaceAll('e', '2.718281828459045')
          // --- [THÊM MỚI] Xử lý các phép toán khoa học ---
          .replaceAll('x²', '^2')
          .replaceAll('x^y', '^')
          .replaceAll('√', 'sqrt')
          .replaceAll('Ln', 'ln')
          .replaceAll('%', '/100');

      if (_angleMode == AngleMode.degrees) {
        // --- [THÊM MỚI] Xử lý góc Độ (Degree) sang Radian ---
        finalExpr = finalExpr
            .replaceAll('sin(', 'sin((3.1415926535897932/180)*')
            .replaceAll('cos(', 'cos((3.1415926535897932/180)*')
            .replaceAll('tan(', 'tan((3.1415926535897932/180)*');
      }

      Parser p = Parser();
      Expression exp = p.parse(finalExpr);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      if (eval.isInfinite || eval.isNaN) {
        _result = "Error";
      } else {
        _result = eval.toStringAsFixed(eval.truncateToDouble() == eval ? 0 : _decimalPrecision);
      }

      historyProvider.addRecord(CalculationHistory(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        expression: _expression,
        result: _result,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      _result = "Error"; 
    }
    notifyListeners();
  }

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