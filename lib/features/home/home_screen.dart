import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../menu/menu_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1; // Default to the 'Home' icon (camera)

  void _onTabTapped(int index) {
    // This is for the visual state of the bottom bar.
    // Navigation is handled by the onTap of each item.
    if (index == _currentIndex) return;
    
    switch (index) {
      case 0:
        context.push('/encargo');
        break;
      case 1:
        context.push('/gallery');
        break;
      case 2:
        // TODO: Create and navigate to payments screen
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/icon.png', height: 40), // Using your app icon as logo
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: theme.colorScheme.primary),
      ),
      drawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            _SummaryCard(
              title: 'Mini Calendario',
              icon: Icons.calendar_today,
              content: '3 recordatorios pendientes',
            ),
            SizedBox(height: 16),
            _SummaryCard(
              title: 'Pedidos en Envío',
              icon: Icons.local_shipping,
              content: '2 pedidos en camino',
            ),
            SizedBox(height: 16),
            _SummaryCard(
              title: 'Pedidos en Entrega / Recogida',
              icon: Icons.store,
              content: '5 pedidos listos',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_upward),
            label: 'Encargo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined),
            label: 'Galería',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Pagos',
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.icon,
    required this.content,
  });

  final String title;
  final IconData icon;
  final String content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(title, style: theme.textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 12),
            Text(content, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}