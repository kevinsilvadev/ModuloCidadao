import 'package:flutter/material.dart';
import 'package:modulo_cidadao/screens/metodosPagamento.dart';
import 'package:cloud_functions/cloud_functions.dart';


class seleciona_ticket extends StatefulWidget {
  const seleciona_ticket({Key? key}) : super(key: key);

  @override
  _seleciona_ticketState createState() => _seleciona_ticketState();
}

class _seleciona_ticketState extends State<seleciona_ticket> {


  int _counter = 0;

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
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }
  }

  String placaDoVeiculo = '';
  String cpf = '';
  String cnpj = '';


  @override
  Widget build(BuildContext context) {

    Future<void> insertTicket(String placaDoVeiculo, int estadia) async {
      HttpsCallable callable = FirebaseFunctions.instanceFor(region: "southamerica-east1").httpsCallable('addNewTicket');
      final resp = await callable.call(<String, dynamic>{
        'placaDoVeiculo': placaDoVeiculo,
        'estadia': 3
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
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Placa do Veículo',
                      ),
                    ),
                    const Text('Digite o CPF ou CNPJ:',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'CPF',
                      ),
                    ),
                    const TextField(
                      obscureText: true,
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
                      insertTicket(placaDoVeiculo, 3);
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => metodosPagamento()),
                      );
                    },
                  )
              )

            ],
          )
        )
    );

  }


}