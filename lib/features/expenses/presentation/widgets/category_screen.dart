import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _items = <String>['Makanan', 'Transport', 'Tagihan', 'Hiburan'];

  Future<void> _add() async {
    final ctrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Tambah Kategori'),
            content: TextField(
              controller: ctrl,
              decoration: const InputDecoration(hintText: 'Nama kategori'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Batal'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Simpan'),
              ),
            ],
          ),
    );
    if (ok == true && ctrl.text.trim().isNotEmpty) {
      setState(() => _items.add(ctrl.text.trim()));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Kategori ditambahkan')));
    }
  }

  Future<void> _rename(int i) async {
    final ctrl = TextEditingController(text: _items[i]);
    final ok = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Ubah Kategori'),
            content: TextField(
              controller: ctrl,
              decoration: const InputDecoration(hintText: 'Nama kategori'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Batal'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Simpan'),
              ),
            ],
          ),
    );
    if (ok == true && ctrl.text.trim().isNotEmpty) {
      setState(() => _items[i] = ctrl.text.trim());
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Kategori diubah')));
    }
  }

  void _delete(int i) {
    final removed = _items.removeAt(i);
    setState(() {});
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Hapus "$removed"')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [IconButton(onPressed: _add, icon: const Icon(Icons.add))],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _items.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder:
            (_, i) => ListTile(
              leading: const Icon(Icons.label_outline),
              title: Text(_items[i]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _rename(i),
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () => _delete(i),
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
