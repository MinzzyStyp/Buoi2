import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Chế độ tối (Dark Mode)'),
            secondary: const Icon(Icons.dark_mode),
            value: themeProvider.isDark,
            onChanged: (bool value) => themeProvider.toggleTheme(value),
          ),
          const ListTile(
            leading: Icon(Icons.calculate),
            title: Text('Độ chính xác thập phân'),
            subtitle: Text('2 chữ số (Mặc định)'),
          ),
          ListTile(
            leading: const Icon(Icons.vibration),
            title: const Text('Phản hồi xúc giác'),
            trailing: Icon(Icons.toggle_on, color: Colors.green[400]),
          ),
        ],
      ),
    );
  }
}