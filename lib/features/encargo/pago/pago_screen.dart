import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/core/models/pago_model.dart';
import 'package:flutter_app/core/services/encargo_service.dart';

class PagoScreen extends ConsumerStatefulWidget {
  const PagoScreen({super.key});

  @override
  ConsumerState<PagoScreen> createState() => _PagoScreenState();
}

class _PagoScreenState extends ConsumerState<PagoScreen> {
  PaymentMethod? _paymentMethod;
  CashPaymentStatus? _cashPaymentStatus;

  @override
  void initState() {
    super.initState();
    final existing = ref.read(encargoServiceProvider).pago;
    if (existing != null) {
      _paymentMethod = existing.paymentMethod;
      _cashPaymentStatus = existing.cashPaymentStatus;
    }
  }

  void _onSave() {
    if (_paymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecciona un método de pago')),
      );
      return;
    }
    
    final newPago = Pago(
      paymentMethod: _paymentMethod,
      cashPaymentStatus: _paymentMethod == PaymentMethod.efectivo ? _cashPaymentStatus : null,
    );
    ref.read(encargoServiceProvider.notifier).updatePago(newPago);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paso 4: Pago'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Métodos de Pago', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          RadioListTile<PaymentMethod>(
            title: const Text('Mastercard'),
            value: PaymentMethod.mastercard,
            groupValue: _paymentMethod,
            onChanged: (v) => setState(() => _paymentMethod = v),
          ),
          RadioListTile<PaymentMethod>(
            title: const Text('PayPal'),
            value: PaymentMethod.paypal,
            groupValue: _paymentMethod,
            onChanged: (v) => setState(() => _paymentMethod = v),
          ),
          RadioListTile<PaymentMethod>(
            title: const Text('Efectivo'),
            value: PaymentMethod.efectivo,
            groupValue: _paymentMethod,
            onChanged: (v) => setState(() => _paymentMethod = v),
  
          ),
          if (_paymentMethod == PaymentMethod.efectivo)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: DropdownButtonFormField<CashPaymentStatus>(
                value: _cashPaymentStatus,
                decoration: const InputDecoration(
                  labelText: 'Estado del pago en efectivo',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: CashPaymentStatus.pendiente, child: Text('Pendiente')),
                  DropdownMenuItem(value: CashPaymentStatus.pagado, child: Text('Pagado')),
                ],
                onChanged: (value) => setState(() => _cashPaymentStatus = value),
              ),
            ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _onSave,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Guardar y Pagar'),
          ),
        ],
      ),
    );
  }
}