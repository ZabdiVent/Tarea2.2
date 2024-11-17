import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  final String? email;

  const Homepage({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido')),
      body: Center(
        child: Text('Correo: $email'),
      ),
    );
  }
}