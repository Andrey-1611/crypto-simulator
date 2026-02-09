import 'package:Bitmark/app/router/app_router.dart';
import 'package:Bitmark/app/runner/app_dependencies.dart';
import 'package:Bitmark/app/widgets/loader.dart';
import 'package:Bitmark/app/widgets/unknown_error.dart';
import 'package:Bitmark/core/constants/locales_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../core/theme/theme.dart';
import '../features/settings/providers/settings_provider.dart';
import '../generated/l10n.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsP = ref.watch(settingsNotifierProvider);
    return ScreenUtilInit(
      designSize: const Size(427, 952),
      builder: (context, child) => settingsP.when(
        data: (settings) => MaterialApp.router(
          theme: settings.theme ? darkTheme : lightTheme,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: Locale(
            settings.language ? LocalesConstants.en : LocalesConstants.ru,
          ),
          routerConfig: ref
              .read(appRouterProvider)
              .config(
                navigatorObservers: () => [
                  TalkerRouteObserver(ref.read(talkerProvider)),
                ],
              ),
        ),
        error: (_, _) =>
            const MaterialApp(home: Scaffold(body: UnknownError())),
        loading: () => const Loader(),
      ),
    );
  }
}
