import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/mock_data.dart';

class DetalleTurnoScreen extends StatelessWidget {
  final String id;
  const DetalleTurnoScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // Buscamos el turno. Si no existe, mostramos error.
    final turno = MockData.turnos.where((t) => t.id == id).firstOrNull;

    if (turno == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalle del turno')),
        body: const Center(child: Text('No encontramos este turno')),
      );
    }

    final cliente =
        MockData.clientes.firstWhere((c) => c.id == turno.clienteId);
    final estilista =
        MockData.estilistas.firstWhere((e) => e.id == turno.estilistaId);

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del turno')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cliente.nombre,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('Teléfono: ${cliente.telefono}'),
                    const Divider(),
                    Text(
                        'Fecha: ${DateFormat('dd/MM/yyyy').format(turno.fechaInicio)}'),
                    Text(
                        'Hora: ${DateFormat('HH:mm').format(turno.fechaInicio)}'),
                    Text('Estilista: ${estilista.nombre}'),
                    Text('Estado: ${turno.estado.toUpperCase()}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Servicios',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...turno.serviciosIds.map((sId) {
              final s = MockData.servicios.firstWhere((s) => s.id == sId);
              return ListTile(
                title: Text(s.nombre),
                trailing: Text('\$${s.precio}'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
