import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';


class credit_card_page extends StatefulWidget {
  const credit_card_page({Key? key}) : super(key: key);

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
      HttpsCallable callable = FirebaseFunctions.instanceFor(region: "southamerica-east1").httpsCallable('paymentSimulator');
      final resp = await callable.call(<String, dynamic>{
        'cardNumber': cardNumber,
        'date': expiryDate,
        'name': cardHolderName,
        'cvv': cvvCode,
        'value': 30
      });
      print("result: ${resp.data}");
    }
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Cartão de Crédito'),
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
