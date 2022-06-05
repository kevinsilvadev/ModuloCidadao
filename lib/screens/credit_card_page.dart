import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:modulo_cidadao/main.dart';
import 'package:modulo_cidadao/screens/maps.dart';
import 'package:modulo_cidadao/screens/metodosPagamento.dart';


class credit_card_page extends StatefulWidget {


  List zonaAzulComerciosNomes;
  List zonaAzulComerciosNomes2;
  int _counter;
  int valorDoTicket;
  String placaDoVeiculo;
  credit_card_page(this.valorDoTicket, this._counter, this.placaDoVeiculo, this.zonaAzulComerciosNomes, this.zonaAzulComerciosNomes2);

  @override
  _credit_card_pageState createState() => _credit_card_pageState();
}

class _credit_card_pageState extends State<credit_card_page> {

  //Código daqui pra baixo
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  String paymentResult = '';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future<void> payment() async {
      HttpsCallable callable = FirebaseFunctions.instanceFor(region: "southamerica-east1").httpsCallable('paymentSimulator2');
      final resp = await callable.call(<String, dynamic>{
        'cardNumber': cardNumber,
        'cardValidityYear': expiryDate,
        'cardHolderName': cardHolderName,
        'cvv': cvvCode,
        'plate': widget.placaDoVeiculo,
        'hoursAcquired': widget._counter,
        'amount': widget.valorDoTicket,
      });
      paymentResult = resp.data["status"];
      print(resp.data["status"]);
      return resp.data["status"];
    }


    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: const Text('Cartão de Crédito'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,),
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CreditCardForm(cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode, onCreditCardModelChange: onCreditCardModelChange,
                        themeColor: Colors.blue,
                        formKey: formKey,
                        cardNumberDecoration:const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Number',
                            hintText: 'xxxx xxxx xxxx xxxx'
                        ),
                        expiryDateDecoration:const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Expired Date',
                            hintText: 'xx/xx'
                        ),
                        cvvCodeDecoration:const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'CVV',
                            hintText: 'xxx'
                        ),
                        cardHolderDecoration:const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Card Holder',
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            primary: const Color(0xff1b447b)
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          child: const Text(
                            'validate',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'halter',
                              fontSize: 14,
                              package: 'flutter_credit_card',
                            ),
                          ),
                        ),
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            payment();
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Processando ...'),
                            ));
                            Future.delayed(const Duration(seconds: 3), () {
                              print(paymentResult);
                              print('valid');
                              if (paymentResult == 'TRANSACAO_EFETUADA'){
                                final AlertDialog infoTicket = AlertDialog(
                                  title: Text('Pagamento Efetuado!',
                                    textAlign: TextAlign.center,),
                                  //chamar infos do banco da área aqui
                                  content: Text('Ticket da área comprado com SUCESSO!\nO prazo de estacionamento é de ${widget._counter} horas.\nValor do ticket: R\$ 0${widget.valorDoTicket},00',
                                      textAlign: TextAlign.center),
                                  actions: [
                                    FlatButton(
                                      textColor: Color(0xFF6200EE),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => maps(polylineList, polylineList2, zonaAzulComercios, zonaAzulComercios2, zonaAzulComerciosNomes,zonaAzulComerciosNomes2)),
                                        );
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                                showDialog(context: context, builder: (context) => infoTicket);
                              } else if (paymentResult == 'CARTAO_INVALIDO'){
                                final AlertDialog infoTicketFalha = AlertDialog(
                                  title: Text('Transação NÃO Efetuada!',
                                    textAlign: TextAlign.center,),
                                  //chamar infos do banco da área aqui
                                  content: Text('O ticket não pode ser adquirido, pois o cartão digitado não é válido.',
                                      textAlign: TextAlign.center),
                                  actions: [
                                    FlatButton(
                                      textColor: Color(0xFF6200EE),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => metodosPagamento(widget.valorDoTicket, widget._counter, widget.placaDoVeiculo, widget.zonaAzulComerciosNomes, widget.zonaAzulComerciosNomes2)),
                                        );
                                      },
                                      child: Text('OK'),
                                    ),
                                    FlatButton(
                                      textColor: Color(0xFF6200EE),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => maps(polylineList, polylineList2, zonaAzulComercios, zonaAzulComercios2, zonaAzulComerciosNomes,zonaAzulComerciosNomes2)),
                                        );
                                      },
                                      child: Text('CANCELAR COMPRA'),
                                    ),
                                  ],
                                );
                                showDialog(context: context, builder: (context) => infoTicketFalha);
                              } else if (paymentResult == 'TRANSACAO_NAO_AUTORIZADA') {
                                final AlertDialog infoTicketFalha = AlertDialog(
                                  title: Text('Transação NÃO Autorizada!',
                                    textAlign: TextAlign.center,),
                                  //chamar infos do banco da área aqui
                                  content: Text('O ticket não pode ser adquirido, pois a transação do pagamento não pode ser efetuada com sucesso.',
                                      textAlign: TextAlign.center),
                                  actions: [
                                    FlatButton(
                                      textColor: Color(0xFF6200EE),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => metodosPagamento(widget.valorDoTicket, widget._counter, widget.placaDoVeiculo, widget.zonaAzulComerciosNomes, widget.zonaAzulComerciosNomes2)),
                                        );
                                      },
                                      child: Text('OK'),
                                    ),
                                    FlatButton(
                                      textColor: Color(0xFF6200EE),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => maps(polylineList, polylineList2, zonaAzulComercios, zonaAzulComercios2, zonaAzulComerciosNomes,zonaAzulComerciosNomes2)),
                                        );
                                      },
                                      child: Text('CANCELAR COMPRA'),
                                    ),
                                  ],
                                );
                                showDialog(context: context, builder: (context) => infoTicketFalha);
                              }
                            });
                          }
                          else{
                            print('inValid');
                          }
                        },)
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }


  void onCreditCardModelChange(CreditCardModel creditCardModel){
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
