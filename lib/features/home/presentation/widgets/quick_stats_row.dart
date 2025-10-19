import 'package:flutter/material.dart';

class QuickStatsRow extends StatelessWidget {
  const QuickStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final c = Theme.of(context).colorScheme;

    Widget stat(String label, String value, IconData icon, Color color) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: t.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      label,
                      style: t.labelMedium?.copyWith(
                        color: c.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, size) {
        final wide = size.maxWidth > 600;
        final children = [
          Expanded(
            child: stat(
              'Unread Messages',
              '12',
              Icons.mail_outline,
              Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: stat(
              'Tasks Today',
              '5',
              Icons.check_circle_outline,
              Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: stat(
              'New Notifications',
              '3',
              Icons.notifications_outlined,
              Colors.orange,
            ),
          ),
        ];
        return wide
            ? Row(children: children)
            : Column(
              children: [
                stat('Unread Messages', '12', Icons.mail_outline, Colors.blue),
                const SizedBox(height: 16),
                stat('Tasks Today', '5', Icons.check_circle_outline, Colors.green),
                const SizedBox(height: 16),
                stat('New Notifications', '3', Icons.notifications_outlined, Colors.orange),
              ],
            );
      },
    );
  }
}
