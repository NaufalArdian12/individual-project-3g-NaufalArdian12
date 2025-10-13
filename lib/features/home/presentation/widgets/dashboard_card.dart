import 'package:flutter/material.dart';
import '../../../../shared/widgets/ink_scale.dart';
import '../../../../shared/widgets/animated_card.dart';

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
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item.icon,
                  size: 24,
                  color: item.color,
                ),
              ),
              const Spacer(),
              
              // Title
              Text(
                item.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              
              // Subtitle
              Text(
                'Tap to open',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: c.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
