import 'package:flutter/material.dart';
import 'package:pemrograman_mobile/features/auth/data/datasources/session_local_data_source.dart';
import 'package:pemrograman_mobile/features/auth/domain/models/user.dart';
import 'package:pemrograman_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:pemrograman_mobile/features/auth/domain/repositories/auth_repository_impl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullname = TextEditingController();
  final _email = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final AuthRepository _repo = AuthRepositoryImpl(SessionLocalDataSource());
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _fullname.dispose();
    _email.dispose();
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    final err = await _repo.register(
      User(
        fullname: _fullname.text.trim(),
        email: _email.text.trim(),
        username: _username.text.trim(),
        password: _password.text,
      ),
    );
    setState(() => _loading = false);
    if (err != null) return setState(() => _error = err);
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _fullname,
                decoration: const InputDecoration(
                  labelText: 'Fullname',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (v) => (v == null || v.trim().isEmpty) ? 'Wajib' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Wajib';
                  final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v.trim());
                  return ok ? null : 'Email tidak valid';
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _username,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (v) =>
                        (v == null || v.trim().length < 3)
                            ? 'Min 3 karakter'
                            : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator:
                    (v) =>
                        (v == null || v.length < 6) ? 'Min 6 karakter' : null,
              ),
              const SizedBox(height: 12),
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _loading ? null : _submit,
                  child:
                      _loading
                          ? const CircularProgressIndicator()
                          : const Text('Daftar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
