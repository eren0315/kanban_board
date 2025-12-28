import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import '../../domain/auth/auth_repository.dart';
import '../../domain/auth/user_model.dart';

class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient _client;

  SupabaseAuthRepository(this._client);

  @override
  Future<User?> findUserByUsername(String username) async {
    try {
      final response = await _client
          .from('users')
          .select()
          .eq('username', username)
          .maybeSingle();

      if (response == null) {
        return null;
      }

      return User.fromJson(response);
    } catch (e) {
      throw Exception('Failed to find user: $e');
    }
  }

  @override
  Future<User> createUser(String username) async {
    try {
      final response = await _client
          .from('users')
          .insert({'username': username})
          .select()
          .single();

      return User.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  @override
  Future<User> signIn(String username) async {
    final existingUser = await findUserByUsername(username);
    if (existingUser != null) {
      return existingUser;
    }
    return await createUser(username);
  }
}
