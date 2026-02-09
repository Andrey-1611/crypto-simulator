import 'package:Bitmark/data/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailVerifiedProvider = StreamProvider<bool>((ref) {
  final authRepo = ref.read(authRepositoryProvider);

  return Stream.periodic(
    const Duration(seconds: 1),
  ).asyncMap((_) => authRepo.checkEmailVerification());
});
