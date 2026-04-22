import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/calculation_history.dart';

class HistoryProvider extends ChangeNotifier {
  List<CalculationHistory> _history = [];
  List<CalculationHistory> get history => _history;

  HistoryProvider() {
    _loadFromDisk();
  }

  void addRecord(CalculationHistory record) {
    _history.insert(0, record);
    if (_history.length > 50) _history.removeLast();
    _saveToDisk();
    notifyListeners();
  }

  void clearAllHistory() {
    _history.clear();
    _saveToDisk();
    notifyListeners();
  }

  Future<void> _saveToDisk() async {
    final prefs = await SharedPreferences.getInstance();
    final data = json.encode(_history.map((e) => e.toMap()).toList());
    await prefs.setString('calc_history_final', data);
  }

  Future<void> _loadFromDisk() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('calc_history_final');
    if (data != null) {
      final List decoded = json.decode(data);
      _history = decoded.map((e) => CalculationHistory.fromMap(e)).toList();
      notifyListeners();
    }
  }
}