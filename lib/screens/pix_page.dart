import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modulo_cidadao/main.dart';
import 'package:modulo_cidadao/screens/maps.dart';

class pix_page extends StatefulWidget {

  int _counter;
  int valorDoTicket;
  String placaDoVeiculo;
  pix_page(this.valorDoTicket, this._counter, this.placaDoVeiculo);

  @override
  _pix_pageState createState() => _pix_pageState();
}
String pix = ''; // KEVIN o token gerado entra aqui

class _pix_pageState extends State<pix_page> {

  void getPixKey() async {
    HttpsCallable callable = FirebaseFunctions.instanceFor(region: "southamerica-east1").httpsCallable("pix");
    final results = await callable.call(<String, dynamic>{});
    setState((){
      pix = results.data.toString();
    });
  }


  void initState() {
    super.initState();
    getPixKey();
  }

  @override
  Widget build(BuildContext context) {

    final TextEditingController _textController = TextEditingController(text: pix.toString());

    // This function is triggered when the copy icon is pressed
    Future<void> _copyToClipboard() async {
      await Clipboard.setData(ClipboardData(text: _textController.text));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Chave PIX Copiada!'),
      ));
    }
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text('PIX'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
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
                    Text('Valor do Ticket:',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 3)),
                    //${_counter}
                    Text('R\$ 0${widget.valorDoTicket},00',
                      style: Theme.of(context).textTheme.headline4,),
                  ],
                ),
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
                    Text('Copie o Token Abaixo:',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold, height: 3, fontSize: 30)),


                    //KEVIN... aqui vc gera o token
                    TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Código PIX',
                        icon: IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: (){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Chave PIX Copiada!'),
                            ));
                            _copyToClipboard;
                            Future.delayed(const Duration(seconds: 5), () {

                              final AlertDialog infoTicket = AlertDialog(
                                title: Text('Pagamento Efetuado!',
                                  textAlign: TextAlign.center,),
                                //chamar infos do banco da área aqui
                                content: Text('Seu ticket da \$ foi comprado com SUCESSO!\nO prazo de estacionamento é de ${widget._counter} horas.\nValor do ticket: R\$ 0${widget.valorDoTicket},00',
                                    textAlign: TextAlign.center),
                                actions: [
                                  FlatButton(
                                    textColor: Color(0xFF6200EE),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => maps(polylineList, polylineList2, zonaAzulComercios,zonaAzulComercios2)),
                                      );
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                              showDialog(context: context, builder: (context) => infoTicket);

                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}