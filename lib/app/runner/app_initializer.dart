import 'package:Bitmark/core/utils/network_interceptor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'app_dependencies.dart';
import 'firebase_options.dart';

class AppInitializer {
  static Future<void> init(ProviderContainer container) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FlutterError.onError = (details) =>
        container.read(talkerProvider).handle(details.exception, details.stack);
    final dio = container.read(dioProvider);
    dio.interceptors.add(NetworkInterceptor());
    dio.interceptors.add(TalkerDioLogger());
    await container.read(packageProvider.future);
  }
}
