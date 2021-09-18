import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tienda_virtual/model/cliente.dart';
import 'package:tienda_virtual/model/producto.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tienda_virtual/utils/colores.dart';
import 'menu.dart';

class ListaProductos extends StatefulWidget {
  final String title;
  final Cliente usuario;

  ListaProductos(this.title, this.usuario);

  @override
  _ListaProductosState createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollControllerList = ScrollController();
  List<Producto> lista = [];

  @override
  void initState() {
    super.initState();
    //Leer la lista de productos
    /*lista.add(Producto(
        id: 1,
        categoria: 'Caballero',
        nombre: 'Zapatos',
        descripcion: 'Negro talla 27',
        marca: 'Flexi',
        cantidad: 4,
        precio: 650));
    lista.add(Producto(
        id: 1,
        categoria: 'Dama',
        nombre: 'Blusa',
        descripcion: 'Azul talla chica',
        marca: 'Mango',
        cantidad: 2,
        precio: 470));*/
  }

  Future<bool> leeProductos() async {
    try {
      final _respuesta = await http.Client().get(Uri.http(
          '10.0.2.2',
          '/tienda_virtual/public/api/productos',
          {"api_token": widget.usuario.token}));

      if (_respuesta.statusCode == 200) {
        print("RESPUESTA: " + _respuesta.body);
        List<Map<String, dynamic>> respuestaJSON =
            json.decode(_respuesta.body).cast<Map<String, dynamic>>();
        lista = Producto.fromJSONArray(respuestaJSON);
        return true;
      }
    } on SocketException {
      print('Error de conexión');
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(widget.title,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
        actions: [BackButton()],
      ),
      body: FutureBuilder(
        future: leeProductos(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          } else {
            return _body();
          }
        },
      ),
      drawer: menu(widget.usuario, context),
      backgroundColor: Colores.colorFondo,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: _columnaCentral(),
      ),
    );
  }

  Column _columnaCentral() {
    return Column(
      children: [
        _listaProductos(),
      ],
    );
  }

  ListView _listaProductos() {
    
    return ListView.separated(
        controller: _scrollControllerList,
        itemCount: lista.length,
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(color: Colores.colorBarra, thickness: 1.5, height: 40,),
        itemBuilder: (context, i) {
          return ListTile(
            contentPadding: EdgeInsets.all(15),
            leading: Icon(Icons.help_outline, size: 80, color: Colores.colorBarra,),
            title: Text(
              lista[i].nombre +
                  " " +
                  lista[i].marca +
                  " " +
                  lista[i].descripcion,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            subtitle: Container(padding: EdgeInsets.only(top: 15),  
              child: Column(children: [
                Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lista[i].categoria,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    Text(
                      "\$" + lista[i].precio.toStringAsFixed(2),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                ]),
                Divider(color: Colores.colorFondo,),
                Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Disponible: " +
                      lista[i].cantidad.toString(),
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    Icon(Icons.shopping_cart_outlined, color: Colores.colorBarra, size: 30,),
                ])
              ]),
            ),
            /*trailing: Text(
              "\$" + lista[i].precio.toString(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),*/
          );
        });
    //]
    //);
  }
}
