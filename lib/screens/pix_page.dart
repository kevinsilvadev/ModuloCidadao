import 'package:flutter/material.dart';

class pix_page extends StatefulWidget {
  const pix_page({Key? key}) : super(key: key);

  @override
  _pix_pageState createState() => _pix_pageState();
}

class _pix_pageState extends State<pix_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text('PIX'),
        centerTitle: true,
      ),
    );
  }
}