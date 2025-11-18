import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_model.freezed.dart';
part 'photo_model.g.dart';

@freezed
class Photo with _$Photo {
  const factory Photo({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'album_id') required String albumId,
    String? title,
    required String url,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}
