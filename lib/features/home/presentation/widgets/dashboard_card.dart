import 'package:flutter/material.dart';
import '../../../../shared/widgets/ink_scale.dart';

class DashboardItem {
  final String title;
  final IconData icon;
  final Color color;
  final String route;
  DashboardItem(this.title, this.icon, this.color, this.route);
}

class DashboardCard extends StatelessWidget {
  final DashboardItem item;
  final VoidCallback onTap;
  const DashboardCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    return InkScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              item.color.withOpacity(0.15),
              c.primaryContainer.withOpacity(0.25),
            ],
          ),
          border: Border.all(color: c.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(item.icon, size: 28, color: item.color),
            ),
            const Spacer(),
            Text(
              item.title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              'Tap to open',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: c.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
