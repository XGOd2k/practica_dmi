import 'package:flutter/material.dart';

import 'model/cliente.dart';
import 'utils/colores.dart';
import 'view/login.dart';
import 'view/menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tienda Virtual',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        primaryColor: Colores.colorBarra,
      ),
      home: MyHomePage(title: 'Tienda Virtual'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Cliente usuario;
  bool loading = true;

  repintaConUsuario(Map<String, dynamic> datos) {
    usuario = Cliente.fromJSON(datos['cliente'], datos['token']);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _body(),
      backgroundColor: Colores.colorFondo,
      drawer: usuario != null ? menu(usuario, context) : null,
    );
  }

  Widget _body() {
    if (usuario == null) {
      return Login(this);
    } else {
      return Center(
        child: Text(
          'Bienvenido ' + usuario.nombre,
          style: TextStyle(fontSize: 20),
        ),
      );
    }
  }
}
