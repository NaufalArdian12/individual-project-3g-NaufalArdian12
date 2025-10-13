import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
        leading: IconButton(
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            final router = GoRouter.of(context);
            if (router.canPop()) {
              router.pop();
            } else {
              router.go('/'); 
            }
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'FAQ & Help Center\n\n• Using dashboard\n• Managing profile\n• Messages & settings\n\nContact: support@example.com',
        ),
      ),
    );
  }
}
