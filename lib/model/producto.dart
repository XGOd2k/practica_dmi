import 'package:flutter/material.dart';

class Producto {
  int id;
  String categoria;
  String nombre;
  String descripcion;
  String marca;
  int cantidad;
  double precio;

  Producto(
      {@required this.id,
      @required this.categoria,
      @required this.nombre,
      @required this.descripcion,
      @required this.marca,
      @required this.cantidad,
      @required this.precio});

  static Producto fromJSON(Map<String, dynamic> datos) {
    return Producto(
      id: datos['id'],
      categoria: datos['categoria'],
      nombre: datos['nombre'],
      descripcion: datos['descripcion'],
      marca: datos['marca'],
      cantidad: datos['cantidad'],
      precio: double.parse(datos['precio']),
    );
  }

  static List<Producto> fromJSONArray(List<Map<String, dynamic>> lista) {
    return List.generate(lista.length, (index) {
      return fromJSON(lista[index]);
    });
  }
}
