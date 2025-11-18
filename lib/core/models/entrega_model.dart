import 'package:flutter/foundation.dart';
import 'destinatario_model.dart';

enum DeliveryType { pasaPorEl, porEntrega }
enum PaymentStatus { pagado, conAnticipo }

@immutable
class Entrega {
  const Entrega({
    this.deliveryType,
    this.pickupName,
    this.pickupPhone,
    this.paymentStatus,
    this.deliveryAddress,
    this.recipientName,
    this.noteType,
    this.note,
  });

  // Common fields
  final DeliveryType? deliveryType;
  final PaymentStatus? paymentStatus;

  // 'Pasa por él' fields
  final String? pickupName;
  final String? pickupPhone;

  // 'Por entrega' fields
  final String? deliveryAddress;
  final String? recipientName;
  final NoteType? noteType;
  final String? note;


  Entrega copyWith({
    DeliveryType? deliveryType,
    PaymentStatus? paymentStatus,
    String? pickupName,
    String? pickupPhone,
    String? deliveryAddress,
    String? recipientName,
    NoteType? noteType,
    String? note,
  }) {
    return Entrega(
      deliveryType: deliveryType ?? this.deliveryType,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      pickupName: pickupName ?? this.pickupName,
      pickupPhone: pickupPhone ?? this.pickupPhone,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      recipientName: recipientName ?? this.recipientName,
      noteType: noteType ?? this.noteType,
      note: note ?? this.note,
    );
  }
}
