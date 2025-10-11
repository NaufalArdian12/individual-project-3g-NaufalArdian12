import 'package:flutter/material.dart';

class QuickStatsRow extends StatelessWidget {
  const QuickStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final c = Theme.of(context).colorScheme;

    Widget stat(String label, String value, IconData icon) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: c.surfaceContainerHighest.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: c.outlineVariant),
        ),
        child: Row(children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: c.primary.withOpacity(0.12), shape: BoxShape.circle), child: Icon(icon)),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value, style: t.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            Text(label, style: t.labelMedium?.copyWith(color: c.onSurfaceVariant)),
          ]),
        ]),
      );
    }

    return LayoutBuilder(builder: (context, size) {
      final wide = size.maxWidth > 600;
      final children = [
        Expanded(child: stat('Unread Messages', '12', Icons.mail_outline)),
        const SizedBox(width: 12),
        Expanded(child: stat('Tasks Today', '5', Icons.check_circle_outline)),
        const SizedBox(width: 12),
        Expanded(child: stat('New Notifications', '3', Icons.notifications_outlined)),
      ];
      return wide ? Row(children: children) : Column(children: [
        stat('Unread Messages', '12', Icons.mail_outline),
        const SizedBox(height: 10),
        stat('Tasks Today', '5', Icons.check_circle_outline),
        const SizedBox(height: 10),
        stat('New Notifications', '3', Icons.notifications_outlined),
      ]);
    });
  }
}
