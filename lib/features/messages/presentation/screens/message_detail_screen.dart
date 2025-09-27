import 'package:flutter/material.dart';

class MessageDetailScreen extends StatelessWidget {
  final String messageId;
  const MessageDetailScreen({super.key, required this.messageId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message $messageId')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Full content of message $messageId.\n(UI only)'),
      ),
    );
  }
}
