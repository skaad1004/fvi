import 'package:fpv_fic/domain/domain_extension.dart';

class FondoModel {
  final int id;
  final String nombre;
  final double montoMinimo;
  final String categoria;

  FondoModel({
    required this.id,
    required this.nombre,
    required this.montoMinimo,
    required this.categoria,
  });

  FondoModel.empty() : id = 0, nombre = '', montoMinimo = 0.0, categoria = '';

  FondoModel.fromMap(Map<String, dynamic> map)
    : id = map.getInt('id'),
      nombre = map.getString('nombre'),
      montoMinimo = map.getDouble('montoMinimo'),
      categoria = map.getString('categoria');
}
