import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({super.key});
  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    final bg = (c.brightness == Brightness.light) ? c.surface.withValues(alpha: 0.6) : c.surfaceContainerHighest.withValues(alpha: 0.6);

    return TextField(
      decoration: InputDecoration(
        hintText: 'Search anything…',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: bg,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: c.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: c.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: c.primary, width: 1.6),
        ),
      ),
      onSubmitted: (q) {
        if (q.trim().isEmpty) return;
        context.go('/messages', extra: {'query': q.trim()});
      },
    );
  }
}
