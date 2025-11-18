import 'package:freezed_annotation/freezed_annotation.dart';

part 'album_model.freezed.dart';
part 'album_model.g.dart';

enum AlbumType { catalogo, borrador }

@freezed
class Album with _$Album {
  const factory Album({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String name,
    String? description,
    required AlbumType type,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Album;

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
}
