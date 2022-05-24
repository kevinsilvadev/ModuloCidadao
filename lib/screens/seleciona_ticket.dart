import 'package:flutter/material.dart';
import 'package:modulo_cidadao/screens/metodosPagamento.dart';




class seleciona_ticket extends StatefulWidget {
  const seleciona_ticket({Key? key}) : super(key: key);

  @override
  _seleciona_ticketState createState() => _seleciona_ticketState();
}

class _seleciona_ticketState extends State<seleciona_ticket> {

  String placaDoVeiculo = '';
  String cpf = '';
  String cnpj = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: AppBar(
          title: Text('Seleção do Ticket'),
          centerTitle: true,
        ),
        body: Center(
          child: Stack(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: SizedBox(
                  width: 370,
                  height: 215,
                  child: Column(children: const [
                    Text('Digite a Placa do Veículo:',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Placa do Veículo',
                      ),
                    ),
                    Text('Digite o CPF ou CNPJ:',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'CPF',
                      ),
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'CNPJ',
                      ),
                    ),
                  ],),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top:250),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: SizedBox(
                  width: 370,
                  height: 215,
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