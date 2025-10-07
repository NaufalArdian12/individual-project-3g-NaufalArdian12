import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pemrograman_mobile/features/auth/data/datasources/session_local_data_source.dart';
import 'package:pemrograman_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:pemrograman_mobile/features/auth/domain/repositories/auth_repository_impl.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _u = TextEditingController();
  final _p = TextEditingController();
  final AuthRepository _repo = AuthRepositoryImpl(SessionLocalDataSource());
  bool _loading = false;
  String? _error;

  @override
  void dispose() { _u.dispose(); _p.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _error = null; });
    final ok = await _repo.login(_u.text.trim(), _p.text);
    setState(() => _loading = false);
    if (!ok) return setState(() => _error = 'Username atau password salah');

    if (!mounted) return;
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _u,
                decoration: const InputDecoration(labelText: 'Username', border: OutlineInputBorder()),
                validator: (v) => (v==null || v.trim().isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _p,
                decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                obscureText: true,
                validator: (v) => (v==null || v.length<6) ? 'Min 6 karakter' : null,
              ),
              const SizedBox(height: 12),
              if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _loading ? null : _submit,
                  child: _loading ? const CircularProgressIndicator() : const Text('Masuk'),
                ),
              ),
              TextButton(
                onPressed: () => context.push('/register'),
                child: const Text('Belum punya akun? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
