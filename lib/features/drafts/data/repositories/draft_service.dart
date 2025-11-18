import '../../domain/models/draft_album.dart';

class DraftService {
  // final SupabaseClient _supabase = Supabase.instance.client;

  // String _getUserId() {
  //   final user = _supabase.auth.currentUser;
  //   if (user == null) {
  //     throw Exception('User is not authenticated.');
  //   }
  //   return user.id;
  // }

  Future<List<DraftAlbum>> getDraftAlbums() async {
    // Mock implementation
    // ignore: avoid_print
    print('MOCK: getDraftAlbums called, returning empty list.');
    return Future.value([]);
  }

  Future<void> addDraftAlbum({
    required String title,
    String? description,
    List<String>? photoUrls,
    String? classification,
  }) async {
    // Mock implementation
    // ignore: avoid_print
    print('MOCK: addDraftAlbum called with title: $title');
    return Future.value();
  }

  Future<void> updateDraftAlbum(DraftAlbum draftAlbum) async {
    // Mock implementation
    // ignore: avoid_print
    print('MOCK: updateDraftAlbum called for ID: ${draftAlbum.id}');
    return Future.value();
  }

  Future<void> deleteDraftAlbum(String id) async {
    // Mock implementation
    // ignore: avoid_print
    print('MOCK: deleteDraftAlbum called for ID: $id');
    return Future.value();
  }
}
