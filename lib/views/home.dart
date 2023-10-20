import 'package:flutter/material.dart';
import 'package:viacep/models/via_cep_model.dart';
import 'package:viacep/services/B4a.dart';
import 'package:viacep/services/via_cep.dart';
import 'package:viacep/widgets/card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var cepCtrl = TextEditingController(text: "");
  bool loading = false;
  var viacepModel = ViaCepModel.empty();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView(
        children: [
          const Text(
            "Consulta de CEP",
            style: TextStyle(fontSize: 22),
          ),
          TextField(
            controller: cepCtrl,
            keyboardType: TextInputType.number,
            maxLength: 8,
            onChanged: (String value) async {
              value.replaceAll(RegExp(r'[^0-9]'), '');
            },
          ),
          const SizedBox(height: 20),
          TextButton(
              onPressed: () async {
                if (cepCtrl.text.length != 8) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("CEP inválido")));
                  return;
                }
                setState(() {
                  loading = true;
                });
                viacepModel = await ViaCepRepository.consultarCEP(
                    cepCtrl.text.replaceAll(RegExp(r'[^0-9]'), ''));
                debugPrint(viacepModel.toString());
                setState(() {
                  loading = false;
                });
              },
              child: const Text("Consultar")),
          const SizedBox(height: 50),
          CustomCard(viacepModel),
          const SizedBox(height: 20),
          TextButton(
              onPressed: () async {
                B4aRepository repository = B4aRepository();
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Salvando...")));
                await repository.criar(viacepModel);
              },
              child: const Text("Salvar este CEP")),
          if (loading) const Center(child: CircularProgressIndicator())
        ],
      ),
    )));
  }
}
