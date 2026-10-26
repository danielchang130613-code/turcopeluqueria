import 'package:flutter/material.dart';
import '../data/mock_data.dart';

class ClientesScreen extends StatefulWidget {
  const ClientesScreen({super.key});

  @override
  State<ClientesScreen> createState() => _ClientesScreenState();
}

class _ClientesScreenState extends State<ClientesScreen> {
  String _searchQuery = '';
  String _filtroGenero = 'Todos';

  @override
  Widget build(BuildContext context) {
    final filteredClientes = MockData.clientes.where((c) {
      final matchesSearch =
          c.nombre.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              c.telefono.contains(_searchQuery);
      final matchesGenero =
          _filtroGenero == 'Todos' || c.genero == _filtroGenero;
      return matchesSearch && matchesGenero;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Clientes')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar por nombre o teléfono',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
          ),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'Todos', label: Text('Todos')),
              ButtonSegment(value: 'Mujer', label: Text('Mujeres')),
              ButtonSegment(value: 'Hombre', label: Text('Hombres')),
            ],
            selected: {_filtroGenero},
            onSelectionChanged: (set) =>
                setState(() => _filtroGenero = set.first),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: filteredClientes.isEmpty
                ? const Center(child: Text('No hay clientes'))
                : ListView.separated(
                    itemCount: filteredClientes.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final cliente = filteredClientes[index];
                      final turnosCount = MockData.turnos
                          .where((t) => t.clienteId == cliente.id)
                          .length;
                      return ListTile(
                        leading: CircleAvatar(child: Text(cliente.nombre[0])),
                        title: Text(cliente.nombre),
                        subtitle:
                            Text('${cliente.telefono} · ${cliente.genero}'),
                        trailing: Text('$turnosCount turnos'),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
