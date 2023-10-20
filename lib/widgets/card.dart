import 'package:flutter/material.dart';
import 'package:viacep/models/via_cep_model.dart';

class CustomCard extends StatefulWidget {
  final ViaCepModel _CEP;

  final String _strDefault = "_____";

  const CustomCard(
    this._CEP, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 15),
        Center(
          child: Text(
            widget._CEP.cep ?? widget._strDefault,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget._CEP.localidade ?? "____"),
            const Text(" - "),
            Text(widget._CEP.uf ?? "____"),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  const TableCell(child: Text("Logradouro: ")),
                  TableCell(
                    child: Text(widget._CEP.logradouro ?? widget._strDefault),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const TableCell(child: Text("Bairro: ")),
                  TableCell(
                    child: Text(widget._CEP.bairro ?? widget._strDefault),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const TableCell(child: Text("Complemento: ")),
                  TableCell(
                    child: Text(widget._CEP.complemento ?? widget._strDefault),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const TableCell(child: Text("IBGE: ")),
                  TableCell(
                    child: Text(widget._CEP.ibge ?? widget._strDefault),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const TableCell(child: Text("GIA: ")),
                  TableCell(
                    child: Text(widget._CEP.gia ?? widget._strDefault),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const TableCell(child: Text("DDD")),
                  TableCell(
                    child: Text(widget._CEP.ddd ?? widget._strDefault),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const TableCell(child: Text("Siafi")),
                  TableCell(
                    child: Text(widget._CEP.siafi ?? widget._strDefault),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 15)
      ]),
    );
  }
}
