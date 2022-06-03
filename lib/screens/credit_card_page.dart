import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:modulo_cidadao/screens/maps.dart';


class credit_card_page extends StatefulWidget {

  int _counter;
  int valorDoTicket;
  String placaDoVeiculo;
  credit_card_page(this.valorDoTicket, this._counter, this.placaDoVeiculo);

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
      print("result: ${resp.data}");
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
                            print('valid');
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
                                      MaterialPageRoute(builder: (context) => maps()),
                                    );
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                            showDialog(context: context, builder: (context) => infoTicket);
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
