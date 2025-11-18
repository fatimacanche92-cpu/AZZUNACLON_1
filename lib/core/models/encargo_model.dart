import 'package:flutter/foundation.dart';
import 'arreglo_model.dart';
import 'entrega_model.dart';
import 'destinatario_model.dart';
import 'pago_model.dart';

@immutable
class Encargo {
  const Encargo({
    this.arreglo,
    this.entrega,
    this.destinatario,
    this.pago,
  });

  final Arreglo? arreglo;
  final Entrega? entrega;
  final Destinatario? destinatario;
  final Pago? pago;

  Encargo copyWith({
    Arreglo? arreglo,
    Entrega? entrega,
    Destinatario? destinatario,
    Pago? pago,
  }) {
    return Encargo(
      arreglo: arreglo ?? this.arreglo,
      entrega: entrega ?? this.entrega,
      destinatario: destinatario ?? this.destinatario,
      pago: pago ?? this.pago,
    );
  }

  bool get isArregloCompleted => arreglo != null && arreglo!.size != null && arreglo!.price != null;
  bool get isEntregaCompleted => entrega != null && entrega!.deliveryType != null;
  bool get isDestinatarioCompleted => destinatario != null && destinatario!.name != null;
  bool get isPagoCompleted => pago != null && pago!.paymentMethod != null;
}
