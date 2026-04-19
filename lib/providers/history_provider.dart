import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/calculation_history.dart';

class HistoryProvider extends ChangeNotifier {
  List<CalculationHistory> _history = [];
  List<CalculationHistory> get history => _history;

  // Phương thức chuẩn để thêm một bản ghi vào danh sách
  void addRecord(CalculationHistory record) {
    _history.insert(0, record); // Thêm vào đầu danh sách
    if (_history.length > 50) _history.removeLast(); // Giới hạn 50 mục
    _saveToDisk(); // Lưu vào bộ nhớ máy
    notifyListeners();
  }

  // Lưu danh sách xuống SharedPreferences [cite: 30]
  Future<void> _saveToDisk() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _history.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('calc_history', data);
  }
}