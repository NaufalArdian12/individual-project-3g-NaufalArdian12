import 'package:flutter/material.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final c = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Dashboard', style: t.headlineMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Row(children: [
              Text('Semoga produktif hari ini! ', style: t.bodyMedium),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: c.primaryContainer, borderRadius: BorderRadius.circular(999)),
                child: Text('v1.0', style: t.labelSmall?.copyWith(color: c.onPrimaryContainer)),
              ),
            ]),
          ]),
        ),
        CircleAvatar(radius: 22, backgroundColor: c.primaryContainer, child: Icon(Icons.person, color: c.onPrimaryContainer)),
      ],
    );
  }
}
