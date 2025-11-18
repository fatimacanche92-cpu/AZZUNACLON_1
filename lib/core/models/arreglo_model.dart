import 'package:flutter/foundation.dart';

enum ArregloSize { p, m, g, eg }

@immutable
class Arreglo {
  const Arreglo({
    this.size,
    this.colors = const [],
    this.flowerType,
    this.price,
  });

  final ArregloSize? size;
  final List<String> colors;
  final String? flowerType;
  final double? price;

  Arreglo copyWith({
    ArregloSize? size,
    List<String>? colors,
    String? flowerType,
    double? price,
  }) {
    return Arreglo(
      size: size ?? this.size,
      colors: colors ?? this.colors,
      flowerType: flowerType ?? this.flowerType,
      price: price ?? this.price,
    );
  }
}
