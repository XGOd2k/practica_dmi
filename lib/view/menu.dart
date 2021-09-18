import 'package:flutter/material.dart';
import 'package:tienda_virtual/model/cliente.dart';
import 'package:tienda_virtual/utils/colores.dart';
import 'package:tienda_virtual/view/listaProductos.dart';

Drawer menu(Cliente usuario, BuildContext context) => Drawer(
      child: DrawerHeader(
          decoration: BoxDecoration(color: Colores.colorBarra),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.bookmark_border, color: Colors.white),
                title: Text('Tienda Virtual',
                    style: TextStyle(fontSize: 30, color: Colors.white)),
                onTap: () => Navigator.of(context).pop(),
              ),
              Divider(color: Colors.white, thickness: 2),
              ListTile(
                leading: Icon(Icons.person_outline, color: Colors.white),
                title: Text(usuario != null ? usuario.nombre : "Cargando...",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.list_alt, color: Colors.white),
                title: Text("Productos",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ListaProductos("Productos", usuario),
                    ),
                  );
                },
              ),
            ],
          )),
    );
