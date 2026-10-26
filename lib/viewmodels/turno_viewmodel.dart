import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/turno.dart';

class TurnoViewModel extends ChangeNotifier {
  final List<Turno> _turnos = List.from(MockData.turnos);
  List<Turno> get turnos => _turnos;

  DateTime _fechaSeleccionada = DateTime.now();
  DateTime get fechaSeleccionada => _fechaSeleccionada;

  String? _filtroEstilistaId;
  String? get filtroEstilistaId => _filtroEstilistaId;

  void cambiarFecha(DateTime nuevaFecha) {
    _fechaSeleccionada = nuevaFecha;
    notifyListeners();
  }

  void filtrarPorEstilista(String? id) {
    _filtroEstilistaId = id;
    notifyListeners();
  }

  List<Turno> get turnosDelDia {
    return _turnos.where((t) {
      bool mismaFecha = t.fechaInicio.year == _fechaSeleccionada.year &&
          t.fechaInicio.month == _fechaSeleccionada.month &&
          t.fechaInicio.day == _fechaSeleccionada.day;
      bool cumpleFiltro =
          _filtroEstilistaId == null || t.estilistaId == _filtroEstilistaId;
      return mismaFecha && cumpleFiltro;
    }).toList()
      ..sort((a, b) => a.fechaInicio.compareTo(b.fechaInicio));
  }

  DateTime calcularFin(Turno turno) {
    int duracionTotal = 0;
    for (var sId in turno.serviciosIds) {
      var servicio = MockData.servicios.firstWhere((s) => s.id == sId);
      duracionTotal += servicio.duracionMinutos;
    }
    return turno.fechaInicio.add(Duration(minutes: duracionTotal));
  }

  double calcularTotal(Turno turno) {
    double total = 0;
    for (var sId in turno.serviciosIds) {
      var servicio = MockData.servicios.firstWhere((s) => s.id == sId);
      total += servicio.precio;
    }
    return total;
  }

  void cambiarEstadoTurno(String turnoId, String nuevoEstado) {
    int index = _turnos.indexWhere((t) => t.id == turnoId);
    if (index != -1) {
      _turnos[index].estado = nuevoEstado;
      _turnos[index].modificadoEn = DateTime.now();
      notifyListeners();
    }
  }
}
