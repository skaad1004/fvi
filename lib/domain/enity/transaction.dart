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
}
