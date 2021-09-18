import 'package:flutter/material.dart';

class Cliente {
  String usuario;
  String nombre;
  String email;
  String telefono;
  String direccion;
  String colonia;
  String ciudad;
  String municipio;
  String estado;
  String token;

  Cliente(
      {@required this.usuario,
      @required this.nombre,
      @required this.email,
      @required this.telefono,
      @required this.direccion,
      @required this.colonia,
      @required this.ciudad,
      @required this.municipio,
      @required this.estado,
      @required this.token});

  static Cliente fromJSON(Map<String, dynamic> datos, String apiToken) {
    return Cliente(
      usuario: datos['usuario'] != null ? datos['usuario'] : '',
      nombre: datos['nombre'] != null ? datos['nombre'] : '',
      email: datos['email'] != null ? datos['email'] : '',
      telefono: datos['telefono'] != null ? datos['telefono'] : '',
      direccion: datos['direccion'] != null ? datos['direccion'] : '',
      colonia: datos['colonia'] != null ? datos['colonia'] : '',
      ciudad: datos['ciudad'] != null ? datos['ciudad'] : '',
      municipio: datos['municipio'] != null ? datos['municipio'] : '',
      estado: datos['estado'] != null ? datos['estado'] : '',
      token: apiToken != null ? apiToken : '',
    );
  }
}
