import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tienda_virtual/utils/colores.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  final MyHomePageState homePage;
  Login(this.homePage);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _usuario = "";
  String _clave = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: columnaCampos(),
        ),
      ),
    );
  }

//Los campos del formulario están dentro de un Column
  Column columnaCampos() {
    return Column(children: <Widget>[
      Divider(height: 40, color: Colores.colorFondo),
      _icono(),
      Divider(height: 20, color: Colores.colorFondo),
      _txtUsuario(),
      Divider(height: 20, color: Colores.colorFondo),
      _txtClave(),
      Divider(height: 60, color: Colores.colorFondo),
      Align(
        alignment: Alignment.bottomRight,
        widthFactor: 4,
        child: botonContinuar(),
      )
    ]);
  }

  ElevatedButton botonContinuar() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          //Validar nombre de usuario y contraseña
          try {
            final _respuesta = await http.Client().get(Uri.http(
                '10.0.2.2',
                '/tienda_virtual/public/api/login',
                {"u": _usuario, "p": _clave}));

            if (_respuesta.statusCode == 200) {
              print("RESPUESTA: " + _respuesta.body);
              Map<String, dynamic> respuestaJSON = json.decode(_respuesta.body);
              if (respuestaJSON['repuesta'] == 'Usuario no válido') {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Usuario No Válido')));
              } else {
                widget.homePage.repintaConUsuario(respuestaJSON);
              }
            }
          } on SocketException {
            print('Error de conexión');
          }
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('El correo y/o la clave no son correctos'),
          ));
        }
      },
      child: Text('Continuar',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.normal)),
      style: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Color(0xFF33AAAA))),
    );
  }

  Icon _icono() => Icon(
        Icons.person_outline,
        color: Colors.cyan,
        size: 100,
      );

  TextFormField _txtUsuario() => TextFormField(
        initialValue: _usuario,
        decoration: InputDecoration(
            labelText: 'Usuario',
            labelStyle: TextStyle(fontSize: 20),
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            hintText: 'Nombre de usuario'),
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value.isEmpty) {
            return "El nombre de usuario está vacío.";
          }
          return null;
        },
        onSaved: (value) => setState(() => _usuario = value),
      );

  TextFormField _txtClave() => TextFormField(
        initialValue: _clave,
        decoration: InputDecoration(
            labelText: 'Contraseña',
            labelStyle: TextStyle(fontSize: 20),
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            hintText: 'Contraseña de usuario'),
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value.isEmpty) {
            return "La contraseña está vacía.";
          }
          return null;
        },
        onSaved: (value) => setState(() => _clave = value),
      );
}
