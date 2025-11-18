import 'package:flutter/foundation.dart';

enum NoteType { publica, anonima }

@immutable
class Destinatario {
  const Destinatario({
    this.name,
    this.address,
    this.noteType,
    this.note,
  });

  final String? name;
  final String? address;
  final NoteType? noteType;
  final String? note;

  Destinatario copyWith({
    String? name,
    String? address,
    NoteType? noteType,
    String? note,
  }) {
    return Destinatario(
      name: name ?? this.name,
      address: address ?? this.address,
      noteType: noteType ?? this.noteType,
      note: note ?? this.note,
    );
  }
}
