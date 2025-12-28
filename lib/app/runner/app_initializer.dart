import 'package:crypto_simulator/app/runner/app_dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';

class AppInitializer {
  static Future<void> init(ProviderContainer container) async {
    WidgetsFlutterBinding.ensureInitialized();
    final dio = container.read(dioProvider);
    dio.interceptors.add(TalkerDioLogger());
  }
}
