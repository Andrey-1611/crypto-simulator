import 'package:crypto_simulator/app/router/app_router.dart';
import 'package:crypto_simulator/app/runner/app_dependencies.dart';
import 'package:crypto_simulator/app/widgets/loader.dart';
import 'package:crypto_simulator/app/widgets/unknown_error.dart';
import 'package:crypto_simulator/data/repositories/auth_repository.dart';
import 'package:crypto_simulator/features/settings/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';
import '../core/theme/theme.dart';
import '../generated/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      observers: [TalkerRiverpodObserver()],
      child: ScreenUtilInit(
        designSize: const Size(427, 952),
        builder: (context, child) => const _AppView(),
      ),
    );
  }
}

class _AppView extends ConsumerStatefulWidget {
  const _AppView();

  @override
  ConsumerState createState() => __AppViewState();
}

class __AppViewState extends ConsumerState<_AppView> {
  late final AppRouter router;

  @override
  void initState() {
    super.initState();
    router = AppRouter(authRepository: ref.read(authRepositoryProvider));
  }

  @override
  Widget build(BuildContext context) {
    final settingsP = ref.watch(settingsNotifierProvider);
    return settingsP.when(
      data: (settings) => MaterialApp.router(
        theme: settings.theme ? darkTheme : lightTheme,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: Locale(settings.language ? 'en' : 'ru'),
        debugShowCheckedModeBanner: false,
        routerConfig: router.config(
          navigatorObservers: () => [
            TalkerRouteObserver(ref.read(talkerProvider)),
          ],
        ),
      ),
      error: (_, _) => const MaterialApp(home: Scaffold(body: UnknownError())),
      loading: () => const Loader(),
    );
  }
}
