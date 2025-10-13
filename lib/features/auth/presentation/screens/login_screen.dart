import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/expense_animations.dart';
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              constraints: BoxConstraints(maxWidth: size.width > 600 ? 400 : double.infinity),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Section
                    ScaleInAnimation(
                      delay: const Duration(milliseconds: 200),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [colorScheme.primary, colorScheme.secondary],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Welcome Text
                    SlideInAnimation(
                      delay: const Duration(milliseconds: 300),
                      child: Text(
                        'Expense Tracker',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SlideInAnimation(
                      delay: const Duration(milliseconds: 400),
                      child: Text(
                        'Manage your finances smartly',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    
                    // Username Field
                    SlideInAnimation(
                      delay: const Duration(milliseconds: 500),
                      child: TextFormField(
                        controller: _u,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.person_outline),
                          hintText: 'Enter your username',
                        ),
                        validator: (v) => (v==null || v.trim().isEmpty) ? 'Wajib diisi' : null,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Password Field
                    SlideInAnimation(
                      delay: const Duration(milliseconds: 600),
                      child: TextFormField(
                        controller: _p,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline),
                          hintText: 'Enter your password',
                        ),
                        obscureText: true,
                        validator: (v) => (v==null || v.length<6) ? 'Min 6 karakter' : null,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Forgot Password
                    SlideInAnimation(
                      delay: const Duration(milliseconds: 700),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Forgot password feature coming soon!')),
                            );
                          },
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Error Message
                    if (_error != null)
                      SlideInAnimation(
                        delay: const Duration(milliseconds: 800),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline, color: Colors.red.shade600, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _error!,
                                  style: TextStyle(color: Colors.red.shade600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    
                    // Login Button
                    SlideInAnimation(
                      delay: const Duration(milliseconds: 900),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _loading ? null : _submit,
                          child: _loading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Text('Sign In'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Register Link
                    SlideInAnimation(
                      delay: const Duration(milliseconds: 1000),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          TextButton(
                            onPressed: () => context.push('/register'),
                            child: const Text('Sign Up'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
