import 'package:crypto_simulator/app/runner/app_dependencies.dart';
import 'package:crypto_simulator/data/data_sources/auth_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthDataSource(auth: ref.read(authProvider)),
);

abstract interface class AuthRepository {
  Future<String> getUserId();
}
