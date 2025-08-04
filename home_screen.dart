import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String? userName;
  const HomeScreen({super.key, this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo${userName != null ? ', $userName' : ''}!'),
      ),
      body: const Center(
        child: Text(
          "Login efetuado com sucesso!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}