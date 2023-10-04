import 'package:flutter/material.dart';
import 'product_list.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário',
      home: Forms(),
    );
  }
}

class Forms extends StatefulWidget {
  @override
  FormsState createState() => FormsState();
}

class FormsState extends State<Forms> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();


  Color textColor = Colors.black;
  Color borderColor = Colors.grey;

  bool envio = false;

  void _enviar() {
    String email = _email.text;
    String pwd = _pwd.text;

    setState(() {
      if (email == "" || pwd == "") {
        // Se algum campo estiver vazio, altere as cores para indicar erro
        textColor = Colors.red;
        borderColor = Colors.red;
        envio = false;
      } else {
        // Se todos os campos estiverem preenchidos, atualize o mapa _result
        textColor = Colors.blue;
        borderColor = Colors.grey;
        envio = true;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductList(
              email: email,
              pwd: pwd,
            ),
          ),
        );
      }
    });
  }

  void _cancelar() {
    setState(() {
      _email.text = "";
      _pwd.text = "";
      
      textColor = Colors.black;
      borderColor = Colors.grey;

      envio = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 50.0),

              const Text(
                'Formulário',
                style: TextStyle(fontSize: 24.0, color: Colors.blue),
              ),

              const SizedBox(height: 16.0),

              SizedBox(
                width: 300,
                child: TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Entre com email',
                    prefixIcon: Icon(Icons.account_circle_rounded),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16.0),

              SizedBox(
                width: 300,
                child: TextField(
                  controller: _pwd,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Entre com a senha',
                    prefixIcon: Icon(Icons.lock),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 35.0),
              
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
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
