import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:modulo_cidadao/screens/credit_card_page.dart';
import 'package:modulo_cidadao/screens/pix_page.dart';




class metodosPagamento extends StatefulWidget {

  int _counter;
  int valorDoTicket;
  String placaDoVeiculo;
  metodosPagamento(this.valorDoTicket, this._counter, this.placaDoVeiculo);

  @override
  _metodosPagamentoState createState() => _metodosPagamentoState();
}

class _metodosPagamentoState extends State<metodosPagamento> {

  Future<void> getFruit() async {
    HttpsCallable callable = FirebaseFunctions.instanceFor(region: "southamerica-east1").httpsCallable('pix');
    final results = await callable();
    String fruit = results.data;
    print(fruit);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.teal[50],
    appBar: AppBar(
      title: Text('Métodos de Pagamento'),
      centerTitle: true,
    ),
    body: Center(
      child: Column(
        children: [
          GestureDetector(
          onTap: () {
            getFruit();
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => pix_page(widget.valorDoTicket, widget._counter, widget.placaDoVeiculo)),
            );
          },
            child: Card(
                margin: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: SizedBox(
                  width: 370,
                  height: 150,
                  child: Column(
                    children: [
                      Text('PIX',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, height: 3)),
                    ],
                  ),
                ),
            ),
          ),


          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => credit_card_page(widget.valorDoTicket, widget._counter, widget.placaDoVeiculo)),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: SizedBox(
                width: 370,
                height: 150,
                child: Column(
                  children: [
                    Text('Cartão de Crédito',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, height: 3)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

    )

  );

}
