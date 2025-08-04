import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../utils/hash.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onRegisterTap;
  final void Function(Map<String, dynamic> user) onLoginSuccess;
  const LoginScreen({super.key, required this.onRegisterTap, required this.onLoginSuccess});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _obscure = true;
  String? _error;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final hashed = hashPassword(_password);
      final user = await DatabaseHelper.instance.loginUser(_email, hashed);
      if (user != null) {
        widget.onLoginSuccess(user);
      } else {
        setState(() {
          _error = "Email ou senha inválidos";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 12,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Entrar", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 32),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email_rounded),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v != null && v.contains("@") ? null : "Email inválido",
                      onSaved: (v) => _email = v!,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        prefixIcon: const Icon(Icons.lock_rounded),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                      validator: (v) => v != null && v.length >= 6 ? null : "Senha muito curta",
                      onSaved: (v) => _password = v!,
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 16),
                      Text(_error!, style: const TextStyle(color: Colors.red)),
                    ],
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: _login,
                        child: const Text("Entrar", style: TextStyle(fontSize: 18)),
                        child: Text(AppLocalizations.of(context)!.login),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: widget.onRegisterTap,
                      child: const Text("Ainda não tem conta? Registe-se"),
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