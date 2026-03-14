import 'package:fpv_fic/domain/enity/fondo.dart';
import 'package:fpv_fic/domain/enity/usuario.dart';

final List<UsuarioModel> usuariosMock = [
  UsuarioModel(
    id: '1',
    nombre: 'Carlos Ramírez',
    email: 'carlos@btg.com',
    telefono: '+57 300 000 0001',
    password: '1234',
    saldo: 500000.0,
  ),
  UsuarioModel(
    id: '2',
    nombre: 'María López',
    email: 'maria@btg.com',
    telefono: '+57 300 000 0002',
    password: '5678',
    saldo: 500000.0,
  ),
];

final List<FondoModel> fondosMock = [
  FondoModel(
    id: 1,
    nombre: 'FPV_BTG_PACTUAL_RECAUDADORA',
    montoMinimo: 75000,
    categoria: 'FPV',
  ),
  FondoModel(
    id: 2,
    nombre: 'FPV_BTG_PACTUAL_ECOPETROL',
    montoMinimo: 125000,
    categoria: 'FPV',
  ),
  FondoModel(
    id: 3,
    nombre: 'DEUDAPRIVADA',
    montoMinimo: 50000,
    categoria: 'FIC',
  ),
  FondoModel(
    id: 4,
    nombre: 'FDO-ACCIONES',
    montoMinimo: 250000,
    categoria: 'FIC',
  ),
  FondoModel(
    id: 5,
    nombre: 'FPV_BTG_PACTUAL_DINAMICA',
    montoMinimo: 100000,
    categoria: 'FPV',
  ),
];
