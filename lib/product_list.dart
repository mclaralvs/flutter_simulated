import 'package:flutter/material.dart';

import 'purchase_details.dart';

class ProductList extends StatelessWidget {
  final String email;
  final String pwd;

  const ProductList({
    Key? key,
    required this.email,
    required this.pwd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Produtos',
      home: Forms(email: email, pwd: pwd), // Passando os valores para Forms
    );
  }
}

class Forms extends StatefulWidget {
  final String email;
  final String pwd;

  const Forms({
    Key? key,
    required this.email,
    required this.pwd,
  }) : super(key: key);

  @override
  FormsState createState() =>
      FormsState(email: email, pwd: pwd); // Passando os valores para FormsState
}

class FormsState extends State<Forms> {
  final List<Map<String, dynamic>> items = [
    {'id': 1, 'nome': 'Caneca', 'preco': 10.00, 'quantidade': 20},
    {'id': 2, 'nome': 'Xícara', 'preco': 15.00, 'quantidade': 10},
    {'id': 3, 'nome': 'Prato', 'preco': 18.99, 'quantidade': 15},
    {'id': 4, 'nome': 'Colher', 'preco': 6.99, 'quantidade': 30},
    {'id': 5, 'nome': 'Taça', 'preco': 19.99, 'quantidade': 25}
  ];

  final String email;
  final String pwd;

  FormsState({
    required this.email,
    required this.pwd,
  });

  Color textColor = Colors.black;
  Color borderColor = Colors.grey;
  String _result = {'nome': '', 'preco': '', 'quantidade': ''}.toString();

  Map<String, dynamic> _selecteditem = {
    'nome': '',
    'preco': '',
    'quantidade': ''
  };

  bool envio = false;

  void _selecionarItem(Map<String, dynamic> item) {
    setState(() {
      _selecteditem = item;
      _result = item.toString();
    });
  }

  void _enviar() {
    Map<String, dynamic> selecionado = _selecteditem;

    setState(() {
      if (selecionado.isEmpty) {
        textColor = Colors.red;
        _result = "Campo Item obrigatório";
        borderColor = Colors.red;
      } else {
        envio = true;
        textColor = Colors.blue;
        borderColor = Colors.grey;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PurchaseDetails(item: selecionado, email: email),
          ),
        );
      }
    });
  }

  void _cancelar() {
    Map<String, dynamic> sel = _selecteditem;

    setState(() {
      _result = sel.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Produtos'),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 50.0),
            const Text(
              'Lista de Produtos',
              style: TextStyle(fontSize: 24.0, color: Colors.blue),
            ),
            const SizedBox(height: 16.0),
            Text('$email, por favor, selecione um item da lista abaixo:',
                style: TextStyle(fontSize: 16.0, color: Colors.black)),
            const SizedBox(height: 16.0),
            Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['nome'],
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Preço: ' + item['preco'].toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Quantidade: ' + item['quantidade'].toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            ElevatedButton(
                              onPressed: () => _selecionarItem(item),
                              child: const Text('Selecionar'),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            !envio
                ? SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _enviar,
                          child: const Text('Enviar'),
                        ),
                        ElevatedButton(
                          onPressed: _cancelar,
                          child: const Text('Cancelar'),
                        ),
                      ],
                    ))
                : const SizedBox.shrink(),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
