import 'package:math_expressions/math_expressions.dart';

class ExpressionParser {
  static String evaluate(String expression) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      String result = eval.toString();
      if (result.endsWith('.0')) {
        result = result.substring(0, result.length - 2);
      }
      
      return result;
    } catch (e) {
      return 'Error';
    }
  }
}