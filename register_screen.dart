import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../utils/hash.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onLoginTap;
  const RegisterScreen({super.key, required this.onLoginTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _obscure = true;
  String? _error;
  String? _success;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_password != _confirmPassword) {
        setState(() {
          _error = "As senhas não coincidem";
          _success = null;
        });
        return;
      }
      final exists = await DatabaseHelper.instance.emailExists(_email);
      if (exists) {
        setState(() {
          _error = "Email já registrado";
          _success = null;
        });
        return;
      }
      try {
        final hashed = hashPassword(_password);
        await DatabaseHelper.instance.registerUser(_name, _email, hashed);
        setState(() {
          _error = null;
          _success = "Registrado com sucesso! Faça login.";
        });
      } catch (e) {
        setState(() {
          _error = "Erro ao registar";
          _success = null;
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
            width: 420,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Registo", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Nome",
                        prefixIcon: Icon(Icons.person_rounded),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v != null && v.isNotEmpty ? null : "Nome obrigatório",
                      onSaved: (v) => _name = v!,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email_rounded),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v != null && v.contains("@") ? null : "Email inválido",
                      onSaved: (v) => _email = v!,
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    TextFormField(
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        labelText: "Confirmar Senha",
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                      validator: (v) => v != null && v.isNotEmpty ? null : "Confirme a senha",
                      onSaved: (v) => _confirmPassword = v!,
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 16),
                      Text(_error!, style: const TextStyle(color: Colors.red)),
                    ],
                    if (_success != null) ...[
                      const SizedBox(height: 16),
                      Text(_success!, style: const TextStyle(color: Colors.green)),
                    ],
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: _register,
                        child: const Text("Registar", style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextButton(
                      onPressed: widget.onLoginTap,
                      child: const Text("Já tem conta? Entrar"),
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