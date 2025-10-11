import 'package:flutter/material.dart';
import 'dart:math';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // UI-only dummy data
    final byCategory = {
      'Makanan': 350000.0,
      'Transport': 120000.0,
      'Tagihan': 420000.0,
      'Hiburan': 180000.0,
    };
    final total = byCategory.values.fold<double>(0, (a, b) => a + b);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        actions: [
          IconButton(
            tooltip: 'Export CSV (dummy)',
            onPressed: () {
              // UI-only: tampilkan snackbar saja
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exported CSV (UI only)')),
              );
            },
            icon: const Icon(Icons.file_download_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _StatHeader(total: total, count: 24),
          const SizedBox(height: 16),
          _BarCard(title: 'By Category (Dummy)', data: byCategory),
          const SizedBox(height: 16),
          _MonthlyCard(),
        ],
      ),
    );
  }
}

class _StatHeader extends StatelessWidget {
  final double total;
  final int count;
  const _StatHeader({required this.total, required this.count});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final c = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: c.surfaceContainerHighest.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Pengeluaran',
                    style: t.labelMedium?.copyWith(color: c.onSurfaceVariant),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp ${total.toStringAsFixed(0)}',
                    style: t.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Jumlah Transaksi',
                  style: t.labelMedium?.copyWith(color: c.onSurfaceVariant),
                ),
                const SizedBox(height: 4),
                Text(
                  '$count',
                  style: t.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BarCard extends StatelessWidget {
  final String title;
  final Map<String, double> data;
  const _BarCard({required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    final maxV = data.values.fold<double>(0, (a, b) => max(a, b));
    final bars = data.entries.toList();
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            ...bars.map((e) {
              final pct = maxV == 0 ? 0.0 : e.value / maxV;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    SizedBox(width: 90, child: Text(e.key)),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: pct,
                          minHeight: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 80,
                      child: Text(
                        'Rp ${e.value.toStringAsFixed(0)}',
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _MonthlyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 6 bulan terakhir (dummy)
    final months = ['Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep'];
    final values =
        [
          320000,
          280000,
          410000,
          390000,
          450000,
          370000,
        ].map((e) => e.toDouble()).toList();
    final maxV = values.fold<double>(0, (a, b) => max(a, b));

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '6 Bulan Terakhir (Dummy)',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(months.length, (i) {
                  final h = maxV == 0 ? 0.0 : (values[i] / maxV) * 160.0;
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: h,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(months[i]),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
