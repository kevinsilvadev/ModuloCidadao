import 'package:flutter/material.dart';
import 'package:modulo_cidadao/screens/credit_card_page.dart';




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
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(20)
        ),
        child: Text('Cartão de Crédito'),
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => credit_card_page()),
          );
    },
      )
    )

  );

}
