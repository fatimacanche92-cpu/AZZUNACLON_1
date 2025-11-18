import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile_model.dart';
import 'package:path/path.dart';

class ProfileService {
  final SupabaseClient _supabase = Supabase.instance.client;

  String _getUserId() {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      throw Exception('User is not authenticated.');
    }
    return user.id;
  }

  Future<Profile> getProfile() async {
    try {
      final userId = _getUserId();
      final data =
          await _supabase.from('profiles').select().eq('user_id', userId).single();
      return Profile.fromJson(data);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        print('No profile found, creating one.');
        return _createProfile();
      }
      rethrow;
    } catch (e) {
      print('Error in getProfile: $e');
      throw Exception('Error getting profile.');
    }
  }

  Future<Profile> _createProfile() async {
    final user = _supabase.auth.currentUser!;
    final profileData = {
      'id': user.id,
      'user_id': user.id,
      'email': user.email,
      'name': user.userMetadata?['name'] ?? user.email,
      'location': null,
      'businessHours': null,
      'businessDescription': null,
      'socialMediaLinks': [],
    };
    await _supabase.from('profiles').insert(profileData);
    return Profile.fromJson(profileData);
  }

  Future<void> updateProfile(Profile profile) async {
    try {
      final userId = _getUserId();
      final updates = profile.toJson()
        ..remove('id')
        ..remove('user_id')
        ..remove('email');

      await _supabase.from('profiles').update(updates).eq('user_id', userId);
    } catch (e) {
      print('Error in updateProfile: $e');
      throw Exception('Error updating profile.');
    }
  }

  Future<String> uploadAvatar(File image) async {
    try {
      final userId = _getUserId();
      final fileName = basename(image.path);
      final filePath = '$userId/$fileName';

      await _supabase.storage.from('avatars').upload(
            filePath,
            image,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );

      final publicUrl = _supabase.storage.from('avatars').getPublicUrl(filePath);
      
      await _supabase.from('profiles').update({'avatar_url': publicUrl}).eq('user_id', userId);

      return publicUrl;
    } catch (e) {
      print('Error uploading avatar: $e');
      throw Exception('Error uploading avatar.');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      print('Error resetting password: $e');
      throw Exception('Error resetting password.');
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
      throw Exception('Error signing out.');
    }
  }
}