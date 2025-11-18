import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/core/models/destinatario_model.dart';
import 'package:flutter_app/core/services/encargo_service.dart';

class DestinatarioScreen extends ConsumerStatefulWidget {
  const DestinatarioScreen({super.key});

  @override
  ConsumerState<DestinatarioScreen> createState() => _DestinatarioScreenState();
}

class _DestinatarioScreenState extends ConsumerState<DestinatarioScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _noteController = TextEditingController();
  NoteType? _noteType;

  @override
  void initState() {
    super.initState();
    final existing = ref.read(encargoServiceProvider).destinatario;
    if (existing != null) {
      _nameController.text = existing.name ?? '';
      _addressController.text = existing.address ?? '';
      _noteController.text = existing.note ?? '';
      _noteType = existing.noteType;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final newDestinatario = Destinatario(
        name: _nameController.text,
        address: _addressController.text,
        noteType: _noteType,
        note: _noteController.text,
      );
      ref.read(encargoServiceProvider.notifier).updateDestinatario(newDestinatario);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paso 3: Destinatario'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre del Destinatario',
                border: OutlineInputBorder(),
              ),
              validator: (v) => v!.isEmpty ? 'El nombre es obligatorio' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Dirección',
                border: OutlineInputBorder(),
              ),
              validator: (v) => v!.isEmpty ? 'La dirección es obligatoria' : null,
            ),
            const SizedBox(height: 24),
            Text('Nota', style: Theme.of(context).textTheme.titleMedium),
            Row(
              children: [
                Radio<NoteType>(
                  value: NoteType.publica,
                  groupValue: _noteType,
                  onChanged: (v) => setState(() => _noteType = v),
                ),
                const Text('Pública'),
                Radio<NoteType>(
                  value: NoteType.anonima,
                  groupValue: _noteType,
                  onChanged: (v) => setState(() => _noteType = v),
                ),
                const Text('Anónima'),
              ],
            ),
            if (_noteType != null)
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: 'Escribir nota...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
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