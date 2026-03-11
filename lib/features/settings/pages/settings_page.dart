import 'package:Bitmark/app/runner/app_dependencies.dart';
import 'package:auto_route/auto_route.dart';
import 'package:Bitmark/app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/widgets/info_bloc.dart';
import '../../../app/widgets/info_row.dart';
import '../../../app/widgets/loader.dart';
import '../../../app/widgets/size_box.dart';
import '../../../app/widgets/unknown_error.dart';
import '../../../core/utils/dialog_helper.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/toast_helper.dart';
import '../../../generated/l10n.dart';
import '../../auth/providers/auth_provider.dart';
import '../../briefcase/providers/briefcase_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/switch_card.dart';

@RoutePage()
class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  void signOut() async {
    await ref.read(authNotifierProvider.notifier).signOut();
  }

  @override
  void initState() {
    super.initState();
    ref.listenManual(authNotifierProvider, (_, state) {
      state.when(
        loading: () => DialogHelper.loading(context),
        data: (authState) => {
          if (authState == .notAuth) context.pushRoute(const SignInRoute()),
        },
        error: (e, _) {
          context.pop();
          ToastHelper.unknownError();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final userP = ref.watch(briefcaseNotifierProvider(null));
    final settingsP = ref.watch(settingsNotifierProvider);
    final s = S.of(context);
    final packageInfo = ref.read(packageProvider).requireValue;
    return Scaffold(
      appBar: AppBar(
        title: Text(s.settings),
        actions: [
          IconButton(
            onPressed: () => DialogHelper.signOut(context, () => signOut()),
            icon: Icon(Icons.logout, color: theme.colorScheme.error),
          ),
        ],
      ),
      body: Padding(
        padding: .all(16.sp),
        child: Column(
          children: [
            SizeBox(
              height: 0.23,
              child: userP.when(
                data: (data) {
                  final user = data.user;
                  return InfoBloc(
                    title: s.user_data,
                    children: [
                      InfoRow(title: s.name, value: user.name),
                      InfoRow(title: s.email, value: user.email),
                      InfoRow(title: s.created, value: user.createdAt.hourFormat),
                    ],
                  );
                },
                error: (e, _) => UnknownError(error: e),
                loading: () => const Loader(),
              ),
            ),
            settingsP.when(
              data: (settings) => Column(
                children: [
                  SwitchCard(
                    title: s.dark_theme,
                    value: settings.theme,
                    onChanged: () => ref
                        .read(settingsNotifierProvider.notifier)
                        .setTheme(!settings.theme),
                  ),
                  SwitchCard(
                    title: s.english_language,
                    value: settings.language,
                    onChanged: () => ref
                        .read(settingsNotifierProvider.notifier)
                        .setLanguage(!settings.language),
                  ),
                ],
              ),
              error: (e, _) => UnknownError(error: e),
              loading: () => const Loader(),
            ),
            const Spacer(),
            Text(
              '${packageInfo.appName}, ${packageInfo.version} (${packageInfo.buildNumber})',
            ),
          ],
        ),
      ),
    );
  }
}
