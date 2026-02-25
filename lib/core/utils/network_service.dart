import 'package:Bitmark/app/runner/app_dependencies.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkServiceProvider = Provider((ref) {
  return NetworkService(connectivity: ref.read(connectivityProvider));
});

class NetworkService {
  final Connectivity _connectivity;

  NetworkService({required Connectivity connectivity})
    : _connectivity = connectivity;

  Future<bool> connection() async {
    final connection = await _connectivity.checkConnectivity();
    return connection.contains(ConnectivityResult.wifi) ||
        connection.contains(ConnectivityResult.mobile);
  }
}

//class NetworkException implements Exception {}
