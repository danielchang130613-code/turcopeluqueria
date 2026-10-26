import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../data/mock_data.dart';
import '../models/turno.dart';
import '../viewmodels/turno_viewmodel.dart';

class AgendaScreen extends StatefulWidget {
  final String? estilistaFiltroId;
  const AgendaScreen({super.key, this.estilistaFiltroId});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  final TurnoViewModel _vm = TurnoViewModel();

  @override
  void initState() {
    super.initState();
    if (widget.estilistaFiltroId != null) {
      _vm.filtrarPorEstilista(widget.estilistaFiltroId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Turco')),
      body: ListenableBuilder(
        listenable: _vm,
        builder: (context, _) {
          return Column(
            children: [
              _buildDateStrip(),
              _buildSummary(),
              _buildFilters(),
              Expanded(
                child: _vm.turnosDelDia.isEmpty
                    ? const Center(child: Text('No hay turnos para este día'))
                    : ListView.builder(
                        itemCount: _vm.turnosDelDia.length,
                        itemBuilder: (context, index) =>
                            _buildTurnoCard(_vm.turnosDelDia[index]),
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
    );
  }

  Widget _buildDateStrip() {
    final now = DateTime.now();
    final weekDays = List.generate(
        7, (i) => now.subtract(Duration(days: now.weekday - 1 - i)));
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weekDays.length,
        itemBuilder: (context, index) {
          final date = weekDays[index];
          final isSelected = date.day == _vm.fechaSeleccionada.day;
          return GestureDetector(
            onTap: () => _vm.cambiarFecha(date),
            child: Container(
              width: 60,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateFormat('EEE', 'es').format(date),
                      style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey)),
                  Text(date.day.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          color: isSelected ? Colors.white : Colors.black)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummary() {
    final turnos = _vm.turnosDelDia;
    int programados = turnos.where((t) => t.estado == 'programado').length;
    int completados = turnos.where((t) => t.estado == 'completado').length;
    double ingreso = turnos
        .where((t) => t.estado != 'cancelado')
        .fold(0, (sum, t) => sum + _vm.calcularTotal(t));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _summaryItem('$programados', 'Programados'),
          _summaryItem('$completados', 'Completados'),
          _summaryItem('\$${ingreso.toStringAsFixed(0)}', 'Ingreso est.'),
        ],
      ),
    );
  }

  Widget _summaryItem(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          FilterChip(
              label: const Text('Todos'),
              selected: _vm.filtroEstilistaId == null,
              onSelected: (_) => _vm.filtrarPorEstilista(null)),
          ...MockData.estilistas.map((e) => Padding(
                padding: const EdgeInsets.only(left: 8),
                child: FilterChip(
                    label: Text(e.nombre),
                    selected: _vm.filtroEstilistaId == e.id,
                    onSelected: (_) => _vm.filtrarPorEstilista(e.id)),
              )),
        ],
      ),
    );
  }

  Widget _buildTurnoCard(Turno turno) {
    final cliente =
        MockData.clientes.firstWhere((c) => c.id == turno.clienteId);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: () => context.push('/agenda/turno/${turno.id}'),
        title: Text(
            '${DateFormat('HH:mm').format(turno.fechaInicio)} - ${DateFormat('HH:mm').format(_vm.calcularFin(turno))}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(cliente.nombre,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(turno.serviciosIds
                .map((id) =>
                    MockData.servicios.firstWhere((s) => s.id == id).nombre)
                .join(', ')),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: turno.estado == 'programado'
                ? Colors.blue.withOpacity(0.2)
                : (turno.estado == 'completado'
                    ? Colors.green.withOpacity(0.2)
                    : Colors.red.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(turno.estado, style: const TextStyle(fontSize: 12)),
        ),
      ),
    );
  }
}
