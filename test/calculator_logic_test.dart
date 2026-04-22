import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:advancedcalculator_2224802010585_tranvanluan/providers/calculator_provider.dart';
import 'package:advancedcalculator_2224802010585_tranvanluan/providers/history_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Khởi tạo môi trường test

  group('Kiểm thử logic Advanced Calculator', () {
    late CalculatorProvider calculator;
    late HistoryProvider history;

    setUp(() {
      SharedPreferences.setMockInitialValues({}); // Giả lập bộ nhớ
      calculator = CalculatorProvider();
      history = HistoryProvider();
    });

    test('Kiểm tra phép cộng: 10 + 20 = 30', () {
      calculator.addToExpression('10+20');
      calculator.calculate(history);
      expect(calculator.result, '30');
    });

    test('Kiểm tra thứ tự ưu tiên: 2 + 3 * 4 = 14', () {
      calculator.addToExpression('2+3*4');
      calculator.calculate(history);
      expect(calculator.result, '14');
    });
  });
}