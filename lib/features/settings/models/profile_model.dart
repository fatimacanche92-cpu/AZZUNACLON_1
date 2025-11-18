import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    String? name,
    String? floristeria,
    String? email,
    String? telefono,
    String? location,
    String? businessHours,
    String? businessDescription,
    @Default([]) List<String> socialMediaLinks,
    String? avatarUrl,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
