import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    required String id,
    @JsonKey(name: 'full_name') String? name,
    @JsonKey(name: 'shop_name') String? floristeria,
    String? email,
    @JsonKey(name: 'phone') String? telefono,
    @JsonKey(name: 'address') String? location,
    @JsonKey(name: 'schedule') String? businessHours,
    @JsonKey(name: 'shop_description') String? businessDescription,
    @JsonKey(name: 'social_links') @Default([]) List<String> socialMediaLinks,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
