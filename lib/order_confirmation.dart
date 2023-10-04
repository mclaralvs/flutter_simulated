import 'package:flutter/material.dart';
import 'package:app/main.dart';

class OrderConfirmation extends StatelessWidget {
  final Map<String, dynamic> item;
  final String email;
  final String preco;
  final String qtd;

  const OrderConfirmation({
    Key? key,
    required this.email,
    required this.preco,
    required this.item,
    required this.qtd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Confirmação de Compra',
      home: Forms(email: email, item: item, qtd: qtd, preco: preco),
    );
  }
}

class Forms extends StatefulWidget {
  final String email;
  final String preco;
  final String qtd;
  final Map<String, dynamic> item;

  const Forms({
    Key? key,
    required this.email,
    required this.preco,
    required this.item,
    required this.qtd,
  }) : super(key: key);

  @override
  FormsState createState() => FormsState(email: email, item: item, qtd: qtd, preco: preco);
}

class FormsState extends State<Forms> {
  final String email;
  final String preco;
  final String qtd;
  final Map<String, dynamic> item;

  FormsState({
    required this.email,
    required this.preco,
    required this.item,
    required this.qtd,
  });

  Color textColor = Colors.black;
  Color borderColor = Colors.grey;

  void _voltar() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmação de Compra'),
      ),
      body: SingleChildScrollView( // Adicione o SingleChildScrollView aqui
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Alinhe o conteúdo ao topo
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50.0),
              Text(
                'Compra realizada com sucesso!',
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 16.0),
              const Divider(),
              const SizedBox(height: 16.0),
              Text(
                'Email: $email',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 16.0),
              const Divider(),
              const SizedBox(height: 16.0),
              Column(
                children: [
                  Text(
                    'Item: ' + item['nome'],
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Preço Unitário: ' + item['preco'].toString(),
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                'Quantidade: $qtd',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 16.0),
              Text(
                'Preço Total: $preco',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _voltar,
                child: Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
