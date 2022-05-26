import 'package:flutter/material.dart';
import 'package:modulo_cidadao/screens/credit_card_page.dart';
import 'package:modulo_cidadao/screens/pix_page.dart';




class metodosPagamento extends StatefulWidget {
  const metodosPagamento({Key? key}) : super(key: key);

  @override
  _metodosPagamentoState createState() => _metodosPagamentoState();
}

class _metodosPagamentoState extends State<metodosPagamento> {


  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Métodos de Pagamento'),
      centerTitle: true,
    ),
    body: Center(
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20)
            ),
            child: Text('Cartão de Crédito'),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => credit_card_page()),
              );
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20),
            ),
            child: Text('PIX'),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => pix_page()),
              );
            },
          )
        ],
      ),

    )

  );

}
