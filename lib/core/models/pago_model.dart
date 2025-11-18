import 'package:flutter/foundation.dart';

enum PaymentMethod { mastercard, paypal, efectivo }
enum CashPaymentStatus { pendiente, pagado }

@immutable
class Pago {
  const Pago({
    this.paymentMethod,
    this.cashPaymentStatus,
  });

  final PaymentMethod? paymentMethod;
  final CashPaymentStatus? cashPaymentStatus;

  Pago copyWith({
    PaymentMethod? paymentMethod,
    CashPaymentStatus? cashPaymentStatus,
  }) {
    return Pago(
      paymentMethod: paymentMethod ?? this.paymentMethod,
      cashPaymentStatus: cashPaymentStatus ?? this.cashPaymentStatus,
    );
  }
}
