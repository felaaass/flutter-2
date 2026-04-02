import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const JogoApp());
}

class JogoApp extends StatelessWidget {
  const JogoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaSelecionar(),
    );
  }
}


class TelaSelecionar extends StatelessWidget {
  const TelaSelecionar({super.key});

  void _jogar(BuildContext context, String escolhaUsuario) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaResultado(escolhaUsuario: escolhaUsuario),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedra,Papel, Tesoura', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                _imagemCircular('assets/images/padrao.png', 130),
                const SizedBox(height: 15),
                const Text('Escolha do APP', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _botaoEscolha(context, 'assets/images/pedra.png', 'pedra'),
                _botaoEscolha(context, 'assets/images/papel.png', 'papel'),
                _botaoEscolha(context, 'assets/images/tesoura.png', 'tesoura'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget para os botões clicáveis
  Widget _botaoEscolha(BuildContext context, String caminhoImagem, String valor) {
    return GestureDetector(
      onTap: () => _jogar(context, valor),
      child: _imagemCircular(caminhoImagem, 90),
    );
  }

  // Widget para desenhar o círculo cinza em volta da imagem
  Widget _imagemCircular(String caminhoImagem, double tamanho) {
    return Container(
      width: tamanho, height: tamanho,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade400, width: 3),
        color: Colors.grey.shade100,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Image.asset(caminhoImagem, fit: BoxFit.contain),
      ),
    );
  }
}

class TelaResultado extends StatefulWidget {
  final String escolhaUsuario;
  const TelaResultado({super.key, required this.escolhaUsuario});

  @override
  State<TelaResultado> createState() => _TelaResultadoState();
}

class _TelaResultadoState extends State<TelaResultado> {
  String _escolhaApp = '';
  String _resultadoTexto = '';
  String _resultadoImagem = '';

  @override
  void initState() {
    super.initState();
    _calcularJogo();
  }

  void _calcularJogo() {
    List<String> opcoes = ['pedra', 'papel', 'tesoura'];
    _escolhaApp = opcoes[Random().nextInt(3)];

    if (widget.escolhaUsuario == _escolhaApp) {
      _resultadoTexto = 'Empate!';
      _resultadoImagem = 'assets/images/icons8-aperto-de-mãos-100.png';
    } else if ((widget.escolhaUsuario == 'pedra' && _escolhaApp == 'tesoura') ||
        (widget.escolhaUsuario == 'papel' && _escolhaApp == 'pedra') ||
        (widget.escolhaUsuario == 'tesoura' && _escolhaApp == 'papel')) {
      _resultadoTexto = 'Você Venceu!';
      _resultadoImagem = 'assets/images/icons8-vitória-48.png';
    } else {
      _resultadoTexto = 'Você Perdeu!';
      _resultadoImagem = 'assets/images/icons8-perder-48.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedra,Papel, Tesoura', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        automaticallyImplyLeading: false, // Esconde o botão de voltar nativo
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Imagem do App
            _blocoImagemTexto('assets/images/$_escolhaApp.png', 'Escolha do APP'),

            // Imagem do Usuário
            _blocoImagemTexto('assets/images/${widget.escolhaUsuario}.png', 'Sua Escolha'),

            // Ícone de Vitória/Derrota/Empate
            Image.asset(_resultadoImagem, height: 80),

            Text(
              _resultadoTexto,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            // Botão Jogar Novamente
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.pop(context); // Volta para a tela anterior
              },
              child: const Text('Jogar novamente', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _blocoImagemTexto(String caminhoImagem, String texto) {
    return Column(
      children: [
        Container(
          width: 110, height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade400, width: 3),
            color: Colors.grey.shade100,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(caminhoImagem, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 10),
        Text(texto, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }
}