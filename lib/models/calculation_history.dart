class CalculationHistory {
  final String id; // Thêm ID để quản lý danh sách tốt hơn
  final String expression;
  final String result;
  final DateTime timestamp;

  CalculationHistory({
    required this.id,
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  // Chuyển đổi sang Map để lưu vào Shared Preferences thông qua jsonEncode
  Map<String, dynamic> toJson() => {
        'id': id,
        'expression': expression,
        'result': result,
        'timestamp': timestamp.toIso8601String(),
      };

  factory CalculationHistory.fromJson(Map<String, dynamic> json) => CalculationHistory(
        id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
        expression: json['expression'],
        result: json['result'],
        timestamp: DateTime.parse(json['timestamp']),
      );

  // Thêm hàm này để hiển thị thời gian đẹp hơn trên UI
  String get formattedDate => "${timestamp.hour}:${timestamp.minute} - ${timestamp.day}/${timestamp.month}";
}