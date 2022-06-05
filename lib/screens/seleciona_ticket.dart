import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:modulo_cidadao/screens/metodosPagamento.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:modulo_cidadao/Model/notification_service.dart';


class seleciona_ticket extends StatefulWidget {

  List zonaAzulComerciosNomes;
  List zonaAzulComerciosNomes2;
  seleciona_ticket(this.zonaAzulComerciosNomes, this.zonaAzulComerciosNomes2);

  @override
  _seleciona_ticketState createState() => _seleciona_ticketState();
}

class _seleciona_ticketState extends State<seleciona_ticket> {


  int _counter = 1;

  void _incrementCounter() {
    if (_counter < 4){
      setState(() {
        _counter++;
      });
    } else {
      final AlertDialog numMaxHoras = AlertDialog(
        title: Text('Alerta'),
        //chamar infos do banco da área aqui
        content: Text('O número máximo de horas foi atingido! (4 horas)'),
      );
      showDialog(context: context, builder: (context) => numMaxHoras);
    }
  }

  void _decrementCounter() {
    if (_counter > 1) {
      setState(() {
        _counter--;
      });
    }
  }

  int valorDoTicket = 2;

  int _calculaValorTicket(){
    if (_counter == 1) {
      valorDoTicket = 2;
    }
    else if (_counter == 2) {
      valorDoTicket = 4;
    }
    else if (_counter == 3){
      valorDoTicket = 6;
    } else {
      valorDoTicket = 8;
    }
    return valorDoTicket;
  }

  String placaDoVeiculo = '';
  String cpf = '';
  String cnpj = '';


  @override
  Widget build(BuildContext context) {

    Future<void> insertTicket(String placaDoVeiculo) async {
      HttpsCallable callable = FirebaseFunctions.instanceFor(region: "southamerica-east1").httpsCallable('addNewTicket');
      final resp = await callable.call(<String, dynamic>{
        'placaVeiculo': placaDoVeiculo,
        'estadia': _counter
      });
      print("result: ${resp.data}");
    }

    return Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: AppBar(
          title: Text('Seleção do Ticket'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: SizedBox(
                  width: 370,
                  height: 215,
                  child: Column(
                    children:  [
                    const Text('Digite a Placa do Veículo:',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    TextField(
                      onChanged: (text) {
                        placaDoVeiculo = text;
                      },
                      obscureText: false,
                      decoration: const InputDecoration(
                        labelText: 'Placa do Veículo',
                      ),
                    ),
                    const Text('Digite o CPF ou CNPJ:',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    TextField(
                      onChanged: (text) {
                        cpf = text;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'CPF',
                      ),
                    ),
                    TextField(
                      onChanged: (text) {
                        cnpj = text;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'CNPJ',
                      ),
                    ),
                  ],),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: SizedBox(
                  width: 370,
                  height: 215,
                 child: Column(
                   children: [
                     const Text('Escolha Quanto Tempo deseja estacionar:',
                       textAlign: TextAlign.center,
                       overflow: TextOverflow.ellipsis,
                       style: TextStyle(fontWeight: FontWeight.bold)),
                     const Text(
                       'Total de Horas do Ticket:',
                       style: TextStyle(height: 2),
                     ),
                     ElevatedButton(
                       style: ElevatedButton.styleFrom(
                           padding: EdgeInsets.all(20)
                       ),
                       child: Text('+'),
                       onPressed: (){
                         _incrementCounter();
                         tooltip: 'Increment';
                         child: const Icon(Icons.add);
                       },
                     ),
                     Text(
                       '$_counter',
                       style: Theme.of(context).textTheme.headline4,
                     ),
                     ElevatedButton(
                       style: ElevatedButton.styleFrom(
                           padding: EdgeInsets.all(20)
                       ),
                       child: Text('-'),
                       onPressed: (){
                         _decrementCounter();
                       },
                     ),
                   ],
                 ),
                ),
              ),
              Positioned(
                top: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(20)
                    ),
                    child: Text('Realizar Pagamento'),
                    onPressed: (){
                      _calculaValorTicket();
                      if (placaDoVeiculo == '') {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Digite a placa do carro!'),
                        ));
                      } else if (cpf == '' && cnpj == '') {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Digite, pelo menos, o CPF ou CNPJ!'),
                        ));
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => metodosPagamento(valorDoTicket, _counter, placaDoVeiculo, widget.zonaAzulComerciosNomes, widget.zonaAzulComerciosNomes2)),
                        );
                      }
                    },
                  )
              )
            ],
          )
        )
    );

  }


}