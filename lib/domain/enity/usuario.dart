// lib/domain/models/usuario_model.dart

import 'package:fpv_fic/domain/domain_extension.dart';

class UsuarioModel {
  final String id;
  final String nombre;
  final String email;
  final String telefono;
  final String password;
  final double saldo;
  List<int> fondosSuscritos; //TODO: refactor

  // Constructor principal → para los mocks
  UsuarioModel({
    required this.id,
    required this.nombre,
    required this.email,
    required this.telefono,
    required this.password,
    required this.saldo,
    this.fondosSuscritos = const [],
  });

  UsuarioModel.empty()
    : id = '',
      nombre = '',
      email = '',
      telefono = '',
      password = '',
      saldo = 0.0,
      fondosSuscritos = [];

  UsuarioModel.fromMap(Map<String, dynamic> map)
    : id = map.getString('id'),
      nombre = map.getString('nombre'),
      email = map.getString('email'),
      telefono = map.getString('telefono'),
      password = map.getString('password'),
      saldo = map.getDouble('saldo'),
      fondosSuscritos = List<int>.from(map.getList('fondosSuscritos'));

  UsuarioModel copyWith({
    String? id,
    String? nombre,
    String? email,
    String? telefono,
    String? password,
    double? saldo,
    List<int>? fondosSuscritos,
  }) {
    return UsuarioModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      email: email ?? this.email,
      telefono: telefono ?? this.telefono,
      password: password ?? this.password,
      saldo: saldo ?? this.saldo,
      fondosSuscritos: fondosSuscritos ?? this.fondosSuscritos,
    );
  }
}
