import 'package:flutter/material.dart';

class ResultadoPage extends StatelessWidget {
  final Map<String, String> dados;

  const ResultadoPage({super.key, required this.dados});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dados Cadastrados"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Resumo do Cadastro:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(height: 10),
            ...dados.entries.map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "${e.key}: ${e.value}",
                style: const TextStyle(fontSize: 18),
              ),
            )),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Voltar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}