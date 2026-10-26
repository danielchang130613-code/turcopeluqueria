import 'screens/formulario_turno_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/agenda_screen.dart';
import 'screens/clientes_screen.dart';
import 'screens/servicios_screen.dart';
import 'screens/estilistas_screen.dart';
import 'screens/detalle_turno_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/agenda',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/agenda',
              builder: (context, state) {
                final estilistaId = state.uri.queryParameters['estilista'];
                return AgendaScreen(estilistaFiltroId: estilistaId);
              },
              routes: [
                GoRoute(
                  path: 'turno/:id',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) =>
                      DetalleTurnoScreen(id: state.pathParameters['id']!),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: '/clientes',
                builder: (context, state) => const ClientesScreen())
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: '/servicios',
                builder: (context, state) => const ServiciosScreen())
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: '/estilistas',
                builder: (context, state) => const EstilistasScreen())
          ],
        ),
      ],
    ),
  ],
);

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(index,
              initialLocation: index == navigationShell.currentIndex);
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.calendar_today), label: 'Agenda'),
          NavigationDestination(icon: Icon(Icons.people), label: 'Clientes'),
          NavigationDestination(
              icon: Icon(Icons.content_cut), label: 'Servicios'),
          NavigationDestination(icon: Icon(Icons.badge), label: 'Estilistas'),
        ],
      ),
    );
  }
}
