import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('FAQ & Help Center\n\n• Using dashboard\n• Managing profile\n• Messages & settings\n\nContact: support@example.com'),
      ),
    );
  }
}
