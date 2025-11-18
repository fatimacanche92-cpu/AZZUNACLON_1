import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/order_model.dart';

class ShippingOrdersPage extends StatelessWidget {
  const ShippingOrdersPage({super.key});

  // Dummy data for demonstration
  static final List<OrderModel> _shippingOrders = [
    OrderModel(
      id: '001',
      clientName: 'Cliente Ejemplo 1',
      arrangementType: 'Arreglo Floral',
      scheduledDate: DateTime.now(),
      deliveryType: OrderDeliveryType.envio,
      shippingStatus: OrderShippingStatus.enEspera,
      paymentStatus: OrderPaymentStatus.pagado,
      price: 50.0,
    ),
    OrderModel(
      id: '002',
      clientName: 'Cliente Ejemplo 2',
      arrangementType: 'Ramo de Rosas',
      scheduledDate: DateTime.now(),
      deliveryType: OrderDeliveryType.envio,
      shippingStatus: OrderShippingStatus.enCamino,
      paymentStatus: OrderPaymentStatus.pagado,
      price: 75.0,
    ),
    OrderModel(
      id: '003',
      clientName: 'Cliente Ejemplo 3',
      arrangementType: 'Caja de Girasoles',
      scheduledDate: DateTime.now().subtract(const Duration(days: 1)),
      deliveryType: OrderDeliveryType.envio,
      shippingStatus: OrderShippingStatus.entregado,
      paymentStatus: OrderPaymentStatus.pagado,
      price: 60.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '📦 Pedidos en Envío',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _shippingOrders.length,
        itemBuilder: (context, index) {
          final order = _shippingOrders[index];
          return _ShippingOrderItem(order: order);
        },
      ),
    );
  }
}

class _ShippingOrderItem extends StatelessWidget {
  final OrderModel order;

  const _ShippingOrderItem({required this.order});

  @override
  Widget build(BuildContext context) {
    final statusStyle = _getStatusStyle(order.shippingStatus);

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
              'Pedido #${order.id}',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Cliente: ${order.clientName}',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            Text(
              'Arreglo: ${order.arrangementType}',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fecha: ${DateFormat.yMMMd().format(order.scheduledDate)}',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: statusStyle['color'],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      statusStyle['text']!,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: statusStyle['color'],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  context.push('/order-details', extra: order);
                },
                child: const Text('Ver detalles'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getStatusStyle(OrderShippingStatus? status) {
    switch (status) {
      case OrderShippingStatus.enEspera:
        return {'color': Colors.orange, 'text': 'En espera'};
      case OrderShippingStatus.enCamino:
        return {'color': Colors.blue, 'text': 'En camino'};
      case OrderShippingStatus.entregado:
        return {'color': Colors.green, 'text': 'Entregado'};
      default:
        return {'color': Colors.grey, 'text': 'Desconocido'};
    }
  }
}
