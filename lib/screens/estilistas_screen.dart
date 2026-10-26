import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/mock_data.dart';

class EstilistasScreen extends StatelessWidget {
  const EstilistasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Estilistas'),
            expandedHeight: 120,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: const Center(
                    child:
                        Text('Nuestro Equipo', style: TextStyle(fontSize: 20))),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final estilista = MockData.estilistas[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text(estilista.nombre[0],
                          style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(estilista.nombre),
                    subtitle: Text(
                        'Especialidad: ${estilista.serviciosIds.length} servicios'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Navegación a Agenda con filtro (Parámetro de consulta)
                      context.go('/agenda?estilista=${estilista.id}');
                    },
                  ),
                );
              },
              childCount: MockData.estilistas.length,
            ),
          ),
        ],
      ),
    );
  }
}
