class Turno {
  final String id;
  final String clienteId;
  final String estilistaId;
  final List<String> serviciosIds;
  final DateTime fechaInicio;
  final String? notas;
  String estado;
  final DateTime creadoEn;
  DateTime modificadoEn;

  Turno(
      {required this.id,
      required this.clienteId,
      required this.estilistaId,
      required this.serviciosIds,
      required this.fechaInicio,
      this.notas,
      this.estado = 'programado',
      required this.creadoEn,
      required this.modificadoEn});
}
