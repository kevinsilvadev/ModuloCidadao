    import 'package:flutter/material.dart';

    class EntradaDados extends StatefulWidget {
      @override
      _EntradaDadosState createState() => _EntradaDadosState();
    }

    class _EntradaDadosState extends State<EntradaDados> {
      @override
      Widget build(BuildContext context) {
        return Material(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
              decoration: InputDecoration(
                labelText: 'Placa do Veículo',
                border: OutlineInputBorder(),
              ),
            ),
              TextField(
              decoration: InputDecoration(
              labelText: 'CPF',
              border: OutlineInputBorder(),
              ),
              ),
            ],
          )
          ),
          ));
      }
    }