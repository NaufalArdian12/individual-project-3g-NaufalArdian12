import 'package:flutter/material.dart';

class ExpenseForm extends StatefulWidget {
  final Map<String, dynamic>? initial; // {title, amount(String), date(DateTime), category, note}
  final void Function(Map<String, dynamic> value) onSubmit;
  const ExpenseForm({super.key, this.initial, required this.onSubmit});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _key = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _amount = TextEditingController();
  final _note = TextEditingController();
  DateTime _date = DateTime.now();
  String? _category;

  final _categories = const ['Makanan', 'Transport', 'Tagihan', 'Hiburan', 'Lainnya']; // UI-only

  @override
  void initState() {
    super.initState();
    final i = widget.initial;
    if (i != null) {
      _title.text = i['title']?.toString() ?? '';
      _amount.text = i['amount']?.toString() ?? '';
      _note.text = i['note']?.toString() ?? '';
      _date = (i['date'] is DateTime) ? i['date'] as DateTime : DateTime.now();
      _category = i['category']?.toString() ?? _categories.first;
    } else {
      _category = _categories.first;
    }
  }

  @override
  void dispose() { _title.dispose(); _amount.dispose(); _note.dispose(); super.dispose(); }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: _date,
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    widget.onSubmit({
      'title': _title.text.trim(),
      'amount': _amount.text.trim(),
      'date': _date,
      'category': _category,
      'note': _note.text.trim().isEmpty ? null : _note.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Form(
      key: _key,
      child: Column(
        children: [
          TextFormField(
            controller: _title,
            decoration: const InputDecoration(
              labelText: 'Judul Pengeluaran', prefixIcon: Icon(Icons.edit), border: OutlineInputBorder(),
            ),
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _amount,
                  decoration: const InputDecoration(
                    labelText: 'Nominal (Rp)', prefixIcon: Icon(Icons.payments), border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Wajib diisi';
                    final n = num.tryParse(v.replaceAll('.', '').replaceAll(',', '.'));
                    return (n == null || n <= 0) ? 'Nominal tidak valid' : null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InkWell(
                  onTap: _pickDate,
                  borderRadius: BorderRadius.circular(12),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Tanggal', prefixIcon: Icon(Icons.event), border: OutlineInputBorder(),
                    ),
                    child: Text('${_date.year}-${_date.month.toString().padLeft(2,'0')}-${_date.day.toString().padLeft(2,'0')}'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _category,
            items: _categories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => _category = v),
            decoration: const InputDecoration(
              labelText: 'Kategori', prefixIcon: Icon(Icons.category), border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _note,
            decoration: const InputDecoration(
              labelText: 'Catatan (opsional)', prefixIcon: Icon(Icons.note_alt_outlined), border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.save),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text('SIMPAN', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              style: FilledButton.styleFrom(backgroundColor: cs.primary),
            ),
          ),
        ],
      ),
    );
  }
}
