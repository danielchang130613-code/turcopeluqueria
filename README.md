# App Turco - Gestión de Peluquería

Este proyecto es la solución al Primer Examen Parcial de la asignatura **Programación para Dispositivos Móviles** (Ingeniería Informática, 3er año).

## Descripción
"Turco" es una aplicación móvil desarrollada en Flutter para la gestión de turnos de una peluquería. Permite llevar un control de los clientes, los servicios disponibles, los estilistas y la agenda diaria. Todos los datos se manejan en memoria (Mock Data), simulando el funcionamiento real sin necesidad de un servidor.

## Tecnologías y Arquitectura
- **Framework:** Flutter (Dart).
- **Arquitectura:** MVVM (Model-View-ViewModel) utilizando `ChangeNotifier` nativo para la gestión del estado (sin paquetes externos como Provider, Riverpod o Bloc).
- **Navegación:** `go_router` con `StatefulShellRoute.indexedStack` para mantener el estado de cada pestaña.
- **Tema:** Material 3 con soporte para modo claro y oscuro.

## Requisitos Previos
- Flutter SDK (versión recomendada: **3.16.0** o superior).
- Android Studio (para el SDK de Android y el emulador).
- Un dispositivo Android físico o emulador.

## Inicialización y Ejecución
Para clonar y ejecutar este proyecto en tu entorno local, sigue estos pasos:

1. Clona el repositorio:
   ```bash
   git clone https://github.com/[tu_usuario]/turco.git