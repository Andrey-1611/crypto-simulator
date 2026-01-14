import 'package:crypto_simulator/app/router/app_router.dart';
import 'package:crypto_simulator/app/runner/app_dependencies.dart';
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
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: darkTheme,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      routerConfig: _router.config(
        navigatorObservers: () => [
          TalkerRouteObserver(ref.read(talkerProvider)),
        ],
      ),
    );
  }
}
