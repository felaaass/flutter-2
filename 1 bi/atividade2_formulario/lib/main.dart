import 'package:flutter/material.dart';
import 'resultado_page.dart';

void main() {
  runApp(const MaterialApp(
    home: FormularioCadastro(),
    debugShowCheckedModeBanner: false,
  ));
}

class FormularioCadastro extends StatefulWidget {
  const FormularioCadastro({super.key});

  @override
  State<FormularioCadastro> createState() => _FormularioCadastroState();
}

class _FormularioCadastroState extends State<FormularioCadastro> {
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();

  DateTime? _dataNascimento;
  bool _aceitaTermos = false;
  bool _notificacoes = false;
  String? _estadoCivil;

  final List<String> _estados = ['Solteiro(a)', 'Casado(a)', 'Divorciado(a)', 'Viúvo(a)'];

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? colhida = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (colhida != null) setState(() => _dataNascimento = colhida);
  }

  void _validarESalvar() {
    final int? idadeValida = int.tryParse(_idadeController.text);


    if (_nomeController.text.isEmpty || _idadeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha os campos obrigatórios!")),
      );
      return;
    }

    // Validação extra (idade > 0)
    if (idadeValida == null || idadeValida <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Idade inválida!")),
      );
      return;
    }


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultadoPage(dados: {
          'Nome': _nomeController.text,
          'Idade': _idadeController.text,
          'Estado Civil': _estadoCivil ?? "Não informado",
          'Termos': _aceitaTermos ? "Aceito" : "Recusado",
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro Completo"), backgroundColor: Colors.blueAccent),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: "Nome", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _idadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Idade", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            ListTile(
              shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
              title: Text(_dataNascimento == null ? "Data de Nascimento" : "${_dataNascimento!.day}/${_dataNascimento!.month}/${_dataNascimento!.year}"),
              trailing: const Icon(Icons.calendar_month),
              onTap: () => _selecionarData(context),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Estado Civil", border: OutlineInputBorder()),
              items: _estados.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => _estadoCivil = val),
            ),
            CheckboxListTile(
              title: const Text("Aceita os termos?"),
              value: _aceitaTermos,
              onChanged: (val) => setState(() => _aceitaTermos = val!),
            ),
            SwitchListTile(
              title: const Text("Receber notificações?"),
              value: _notificacoes,
              onChanged: (val) => setState(() => _notificacoes = val),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _validarESalvar,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                child: const Text("SALVAR", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaResultado extends StatelessWidget {
  final Map<String, String> dados;
  const TelaResultado({super.key, required this.dados});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dados Salvos")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: dados.entries.map((e) => Text("${e.key}: ${e.value}", style: const TextStyle(fontSize: 18, height: 2))).toList(),
        ),
      ),
    );
  }
}