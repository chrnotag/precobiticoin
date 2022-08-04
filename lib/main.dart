import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PrecoMoeda(),
    ),
  );
}

class PrecoMoeda extends StatefulWidget {
  const PrecoMoeda({Key? key}) : super(key: key);

  @override
  State<PrecoMoeda> createState() => _PrecoMoedaState();
}

class _PrecoMoedaState extends State<PrecoMoeda> {
  String _precoBitcoin = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Image.asset("images/bitcoin.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Text(
                  _precoBitcoin,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Ubuntu',
                    fontStyle: FontStyle.normal,
                    fontSize: 25,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => _ResgatarValor(),
                child: const Text("Atualizar"),
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.orange.shade900,
                  elevation: 3,
                  onPrimary: Colors.black,
                  primary: Colors.amber,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _ResgatarValor() async {
    Uri url = Uri.parse("https://blockchain.info/ticker");
    http.Response response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String format = retorno["BRL"]["buy"].toString();
    setState(() {
      _precoBitcoin = "R\$ ${format.replaceAll(RegExp(r'\.'), ',')}";
    });
  }
}
