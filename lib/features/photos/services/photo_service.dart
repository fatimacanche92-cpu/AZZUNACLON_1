import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/photo_model.dart';

class PhotoService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> addPhoto({
    required String title,
    required String path,
    String? albumId,
  }) async {
    final photo = Photo(
      id: _supabase.auth.currentUser!.id,
      title: title,
      path: path,
      albumId: albumId,
      createdAt: DateTime.now(),
    );

    final response = await _supabase.from('photos').insert(photo.toJson());

    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<List<Photo>> getPhotos() async {
    try {
      final data = await _supabase
          .from('photos')
          .select()
          .order('created_at', ascending: false);
      return data.map((json) => Photo.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error getting photos: $e');
    }
  }

  Future<List<Photo>> getPhotosByAlbum(String albumId) async {
    try {
      final data = await _supabase
          .from('photos')
          .select()
          .eq('albumId', albumId)
          .order('created_at', ascending: false);
      return data.map((json) => Photo.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error getting photos by album: $e');
    }
  }

  Future<void> deletePhoto(String id) async {
    final response = await _supabase.from('photos').delete().eq('id', id);

    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }
}
