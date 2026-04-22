import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/history_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);
    final historyList = historyProvider.history;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử tính toán'),
        actions: [
          // Nút thùng rác để xóa toàn bộ lịch sử
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              historyProvider.clearAllHistory();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã xóa sạch lịch sử')),
              );
            },
          ),
        ],
      ),
      body: historyList.isEmpty
          ? const Center(
              child: Text(
                'Chưa có lịch sử nào',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                final item = historyList[index];
                return ListTile(
                  title: Text(
                    item.expression,
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  subtitle: Text(
                    '= ${item.result}',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  trailing: Text(
                    '${item.timestamp.hour}:${item.timestamp.minute}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                );
              },
            ),
    );
  }
}