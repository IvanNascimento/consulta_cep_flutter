import 'package:flutter/material.dart';
import 'package:viacep/models/via_cep_model.dart';
import 'package:viacep/services/B4a.dart';
import 'package:viacep/widgets/card.dart';

class Registros extends StatefulWidget {
  const Registros({super.key});

  @override
  State<Registros> createState() => _RegistrosState();
}

class _RegistrosState extends State<Registros> {
  final B4aRepository repository = B4aRepository();
  ViaCepList _cepList = ViaCepList([]);
  bool carregando = false;

  @override
  void initState() {
    super.initState();
    preencherCPEs();
  }

  Future<void> preencherCPEs() async {
    setState(() {
      carregando = true;
    });
    _cepList = await repository.getCEPs();
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return carregando
        ? const Center(child: CircularProgressIndicator())
        : SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                  itemCount: _cepList.ceps.length,
                  itemBuilder: (BuildContext bc, int index) {
                    ViaCepModel cep = _cepList.ceps[index];
                    return InkWell(
                      child: Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: CustomCard(cep),
                      ),
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: const Text("Deletar CEP"),
                                content: const Text(
                                    "Certeza que deseja deletar esse cep ?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Não")),
                                  TextButton(
                                      onPressed: () async {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Deletando elemento")));
                                        Navigator.pop(context);
                                        await repository.remover(cep.objectId!);
                                        await preencherCPEs();
                                      },
                                      child: const Text("Sim"))
                                ],
                              );
                            });
                      },
                    );
                  }),
            ),
          );
  }
}
