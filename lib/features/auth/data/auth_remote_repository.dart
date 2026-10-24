import '../domain/entity/user.dart';

abstract interface class AuthRemoteRepository {
  Future<void> login(User user);
}
