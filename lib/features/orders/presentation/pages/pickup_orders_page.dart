import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/order_model.dart';

class PickupOrdersPage extends StatelessWidget {
  const PickupOrdersPage({super.key});

  // Dummy data for demonstration
  static final List<OrderModel> _pickupOrders = [
    OrderModel(
      id: '004',
      clientName: 'Ana López',
      arrangementType: 'Floral Grande',
      arrangementSize: 'Grande',
      arrangementColor: 'Azul + Blanco',
      arrangementFlowerType: 'Rosas + Alstroemerias',
      scheduledDate: DateTime.now(),
      deliveryType: OrderDeliveryType.recoger,
      paymentStatus: OrderPaymentStatus.conAnticipo,
      price: 650.0,
      downPayment: 300.0,
      remainingAmount: 350.0,
      publicNote: 'Para mamá',
      clientPhone: '999-000-1111',
    ),
    OrderModel(
      id: '005',
      clientName: 'Carlos Pérez',
      arrangementType: 'Rosa Premium',
      scheduledDate: DateTime.now().add(const Duration(days: 1)),
      deliveryType: OrderDeliveryType.recoger,
      paymentStatus: OrderPaymentStatus.pagado,
      price: 420.0,
      publicNote: 'Entrega urgente',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const ImageIcon(AssetImage('assets/icon.png')),
          onPressed: () => context.pop(),
        ),
        title: Text(
          '🛍️ Pedidos por Recoger',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _pickupOrders.length,
        itemBuilder: (context, index) {
          final order = _pickupOrders[index];
          return _PickupOrderItem(order: order);
        },
      ),
    );
  }
}

class _PickupOrderItem extends StatelessWidget {
  final OrderModel order;

  const _PickupOrderItem({required this.order});

  @override
  Widget build(BuildContext context) {
    String paymentStatusText;
    Color paymentStatusColor;

    switch (order.paymentStatus) {
      case OrderPaymentStatus.pagado:
        paymentStatusText = 'Pagado';
        paymentStatusColor = Colors.green;
        break;
      case OrderPaymentStatus.conAnticipo:
        paymentStatusText = 'Con anticipo';
        paymentStatusColor = Colors.orange;
        break;
      case OrderPaymentStatus.pendiente:
        paymentStatusText = 'Pendiente';
        paymentStatusColor = Colors.red;
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cliente: ${order.clientName}',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Arreglo: ${order.arrangementType}',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            Text(
              'Precio: \$${order.price.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Estado de pago: ',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                Text(
                  paymentStatusText,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: paymentStatusColor,
                  ),
                ),
              ],
            ),
            if (order.paymentStatus == OrderPaymentStatus.conAnticipo)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  '(\$${order.downPayment!.toStringAsFixed(2)} pagado, \$${order.remainingAmount!.toStringAsFixed(2)} pendiente)',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  context.push('/order-details', extra: order);
                },
                child: const Text('→ Ver detalles'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
