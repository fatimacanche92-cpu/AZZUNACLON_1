import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _goBranch,
        items: const [
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/icon.png')), label: 'Inicio'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/icon.png')), label: 'Pedidos'),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icon.png')),
            label: 'Cámara',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icon.png')),
            label: 'Estadísticas',
          ),
        ],
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, // Use fixed for more than 3 items
      ),
    );
  }
}
