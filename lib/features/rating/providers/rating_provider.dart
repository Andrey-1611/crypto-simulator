import 'package:crypto_simulator/data/models/app_user.dart';
import 'package:crypto_simulator/data/repositories/remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ratingProvider = FutureProvider<List<AppUser>>((ref) async {
  return ref.read(remoteRepositoryProvider).getUsers();
});
