import '../models/calculator_mode.dart';

class CalculatorSettings {
  int decimalPrecision;
  AngleMode angleMode;
  bool hapticFeedback;

  CalculatorSettings({
    this.decimalPrecision = 2,
    this.angleMode = AngleMode.degrees,
    this.hapticFeedback = true,
  });
}