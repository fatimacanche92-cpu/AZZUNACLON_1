import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/core/models/arreglo_model.dart';
import 'package:flutter_app/core/services/encargo_service.dart';

class ArregloScreen extends ConsumerStatefulWidget {
  const ArregloScreen({super.key});

  @override
  ConsumerState<ArregloScreen> createState() => _ArregloScreenState();
}

class _ArregloScreenState extends ConsumerState<ArregloScreen> {
  final _formKey = GlobalKey<FormState>();
  ArregloSize? _size;
  final _colors = <String>{};
  final _flowerTypeController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final existingArreglo = ref.read(encargoServiceProvider).arreglo;
    if (existingArreglo != null) {
      _size = existingArreglo.size;
      _colors.addAll(existingArreglo.colors);
      _flowerTypeController.text = existingArreglo.flowerType ?? '';
      _priceController.text = existingArreglo.price?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _flowerTypeController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final newArreglo = Arreglo(
        size: _size,
        colors: _colors.toList(),
        flowerType: _flowerTypeController.text,
        price: double.tryParse(_priceController.text),
      );
      ref.read(encargoServiceProvider.notifier).updateArreglo(newArreglo);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paso 1: Arreglo'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Size
            Text('Tamaño', style: Theme.of(context).textTheme.titleMedium),
            Wrap(
              spacing: 8.0,
              children: ArregloSize.values.map((size) {
                return ChoiceChip(
                  label: Text(size.name.toUpperCase()),
                  selected: _size == size,
                  onSelected: (selected) {
                    setState(() => _size = selected ? size : null);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Colors
            Text('Colores', style: Theme.of(context).textTheme.titleMedium),
            Wrap(
              spacing: 8.0,
              children: ['Rojo', 'Blanco', 'Rosa', 'Amarillo', 'Azul'].map((color) {
                return FilterChip(
                  label: Text(color),
                  selected: _colors.contains(color),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _colors.add(color);
                      } else {
                        _colors.remove(color);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Flower Type
            TextFormField(
              controller: _flowerTypeController,
              decoration: const InputDecoration(
                labelText: 'Tipo de Flor',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // Price
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Precio',
                prefixText: '\$',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El precio es obligatorio';
                }
                if (double.tryParse(value) == null) {
                  return 'Ingresa un número válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: _onSave,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}