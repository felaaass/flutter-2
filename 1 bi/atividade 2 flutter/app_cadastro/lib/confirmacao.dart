import 'package:flutter/material.dart';

class ConfirmacaoScreen extends StatelessWidget {
  final String nome;
  final int idade;
  final String email;
  final String sexo;
  final bool termosAceitos;

  const ConfirmacaoScreen({
    super.key,
    required this.nome,
    required this.idade,
    required this.email,
    required this.sexo,
    required this.termosAceitos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dados informados:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text('Nome: $nome', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Text('Idade: $idade', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Text('Email: $email', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Text('Sexo: $sexo', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Text(
              'Termos aceitos: ${termosAceitos ? "Sim" : "Não"}',
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Voltar', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Editar', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}