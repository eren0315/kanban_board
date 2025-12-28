import 'user_model.dart';

abstract class AuthRepository {
  /// Finds a user by their username.
  /// Returns null if not found.
  Future<User?> findUserByUsername(String username);

  /// Creates a new user with the given username.
  Future<User> createUser(String username);

  /// Convenience method to Find or Create.
  Future<User> signIn(String username);
}
