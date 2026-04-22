import 'expression_parser.dart';

class CalculatorLogic {
  static String calculate(String expression) {
    if (expression.isEmpty) return '0';
    String mathExpr = expression
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('π', '3.141592653589793')
        .replaceAll('x²', '^2')
        .replaceAll('x^y', '^')
        .replaceAll('√', 'sqrt');
    mathExpr = mathExpr.replaceAll('Ln', 'ln');
    mathExpr = mathExpr.replaceAll('%', '/100');
    return ExpressionParser.evaluate(mathExpr);
  }
}