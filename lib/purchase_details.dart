import 'package:app/order_confirmation.dart';
import 'package:flutter/material.dart';

class PurchaseDetails extends StatelessWidget {
  final Map<String, dynamic> item;
  final String email;

  const PurchaseDetails({
    Key? key,
    required this.item,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Forms(item: item, email: email),
    );
  }
}

class Forms extends StatefulWidget {
  final Map<String, dynamic> item;
  final String email;

  const Forms({
    Key? key,
    required this.item,
    required this.email,
  }) : super(key: key);

  @override
  FormsState createState() => FormsState(item: item, email: email);
}

class FormsState extends State<Forms> {
  final _quantidade = TextEditingController();
  final _total = TextEditingController();

  final String email;
  final Map<String, dynamic> item;

  FormsState({
    required this.item,
    required this.email,
  });

  Color textColor = Colors.black;
  Color borderColor = Colors.grey;
  String _result = "";
  bool envio = false;

  void _calcular() {
    String qtd = _quantidade.text;
    String preco = item['preco'].toString();

    setState(() {
      if (qtd == "") {
        // Se algum campo estiver vazio, altere as cores para indicar erro
        textColor = Colors.red;
        borderColor = Colors.red;
        envio = false;
      } else {
        textColor = Colors.blue;
        borderColor = Colors.grey;
        envio = true;

        /* if (_result != "") {
          _result = "";
          _total.text = "";
        } */

        _result = (double.parse(qtd) * double.parse(preco)).toString();
        _total.text = _result;
      }
    });
  }

  void _enviar() {
    String qtd = _quantidade.text;
    String preco = item['preco'].toString();

    setState(() {
      if (qtd == "") {
        // Se algum campo estiver vazio, altere as cores para indicar erro
        textColor = Colors.red;
        borderColor = Colors.red;
        envio = false;
      } else {
        textColor = Colors.blue;
        borderColor = Colors.grey;
        envio = true;

        _result = qtd;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderConfirmation(
              item: item,
              email: email,
              qtd: qtd,
              preco: _total.text,
            ),
          ),
        );
      }
    });
  }

  void _cancelar() {
    setState(() {
      _quantidade.text = "";

      textColor = Colors.black;
      borderColor = Colors.grey;

      envio = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Compra'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50.0),
            const Text(
              'Detalhes da Compra',
              style: TextStyle(fontSize: 20.0, color: Colors.blue),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Item: ' + item['nome'],
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Preço: ' + item['preco'].toString(),
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _quantidade,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Entre com quantidade desejada',
                  prefixIcon: Icon(Icons.numbers),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _calcular,
              child: Text('Calcular'),
            ),
            const SizedBox(height: 16.0),
            _total == null || _total.text.isEmpty
                ? Text('')
                : Text(
                    'Total: ' + _total.text,
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _enviar,
                  child: Text('Enviar'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _cancelar,
                  child: Text('Cancelar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
