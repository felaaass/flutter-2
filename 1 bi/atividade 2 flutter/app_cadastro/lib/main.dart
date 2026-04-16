import 'package:flutter/material.dart';
import 'confirmacao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Cadastro',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF6F8FA),
      ),
      home: const CadastroScreen(),
    );
  }
}

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _sexo;
  bool _termosAceitos = false;

  void _validarECadastrar() {
    String nome = _nomeController.text.trim();
    String idadeTexto = _idadeController.text.trim();
    String email = _emailController.text.trim();

    if (nome.isEmpty) {
      _mostrarErro('Nome não pode ser vazio');
      return;
    }

    if (idadeTexto.isEmpty) {
      _mostrarErro('Idade não pode ser vazia');
      return;
    }

    int? idade;
    try {
      idade = int.parse(idadeTexto);
      if (idade < 18) {
        _mostrarErro('Idade deve ser maior ou igual a 18');
        return;
      }
    } catch (e) {
      _mostrarErro('Idade deve ser um número válido');
      return;
    }

    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      _mostrarErro('E-mail inválido');
      return;
    }

    if (_sexo == null) {
      _mostrarErro('Selecione o sexo');
      return;
    }

    if (!_termosAceitos) {
      _mostrarErro('Você deve aceitar os termos de uso');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmacaoScreen(
          nome: nome,
          idade: idade!,
          email: email,
          sexo: _sexo!,
          termosAceitos: _termosAceitos,
        ),
      ),
    );
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Preencha os campos abaixo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _nomeController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Nome',
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _idadeController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Idade',
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Email',
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _sexo,
                decoration: InputDecoration(
                  labelText: 'Sexo',
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
                  DropdownMenuItem(value: 'Feminino', child: Text('Feminino')),
                  DropdownMenuItem(value: 'Outro', child: Text('Outro')),
                ],
                onChanged: (value) {
                  setState(() {
                    _sexo = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _termosAceitos,
                    onChanged: (value) {
                      setState(() {
                        _termosAceitos = value ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'Aceito os termos de uso',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _validarECadastrar,
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}