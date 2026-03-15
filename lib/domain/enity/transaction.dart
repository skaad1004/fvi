enum TipoTransaccion { suscripcion, cancelacion }

enum MetodoNotificacion { email, sms }

enum CategoriaFondo {
  fvp('FPV', 'Fondo de Pensiones Voluntarias'),
  fic('FIC', 'Fondo de Inversión Colectiva');

  final String value;
  final String displayName;

  const CategoriaFondo(this.value, this.displayName);
}

class TransaccionModel {
  final String id;
  final int fondoId;
  final String nombreFondo;
  final CategoriaFondo categoriaFondo;
  final double monto;
  final TipoTransaccion tipo;
  final MetodoNotificacion? metodo;
  final DateTime fecha;

  const TransaccionModel({
    required this.id,
    required this.fondoId,
    required this.nombreFondo,
    required this.categoriaFondo,
    required this.monto,
    required this.tipo,
    this.metodo,
    required this.fecha,
  });

  TransaccionModel copyWith({
    String? id,
    int? fondoId,
    String? nombreFondo,
    CategoriaFondo? categoriaFondo,
    double? monto,
    TipoTransaccion? tipo,
    MetodoNotificacion? metodo,
    DateTime? fecha,
  }) {
    return TransaccionModel(
      id: id ?? this.id,
      fondoId: fondoId ?? this.fondoId,
      nombreFondo: nombreFondo ?? this.nombreFondo,
      categoriaFondo: categoriaFondo ?? this.categoriaFondo,
      monto: monto ?? this.monto,
      tipo: tipo ?? this.tipo,
      metodo: metodo ?? this.metodo,
      fecha: fecha ?? this.fecha,
    );
  }
}
