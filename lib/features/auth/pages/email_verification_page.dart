import 'package:Bitmark/features/auth/providers/email_verified_provider.dart';
import 'package:Bitmark/generated/l10n.dart';
import 'package:auto_route/auto_route.dart';
import 'package:Bitmark/app/router/app_router.dart';
import 'package:Bitmark/app/widgets/loader.dart';
import 'package:Bitmark/core/utils/toast_helper.dart';
import 'package:Bitmark/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/widgets/size_box.dart';
import '../../../core/utils/dialog_helper.dart';
import '../../../core/utils/extensions.dart';

@RoutePage()
class EmailVerificationPage extends ConsumerStatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  ConsumerState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends ConsumerState<EmailVerificationPage> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(emailVerifiedProvider, (_, state) {
      state.when(
        data: (emailVerified) {
          if (emailVerified) {
            context.pushRoute(const HomeRoute());
          }
        },
        error: (_, _) => ToastHelper.unknownError(),
        loading: () {},
      );
    });
  }

  void sendEmailVerification() =>
      ref.read(authNotifierProvider.notifier).sendEmailNotification();

  void checkEmailVerification() =>
      ref.read(authNotifierProvider.notifier).checkEmailVerification();

  void deleteAccount() =>
      ref.read(authNotifierProvider.notifier).deleteAccount();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(s.emailVerification),
        actions: [
          IconButton(
            onPressed: () =>
                DialogHelper.signOut(context, () => deleteAccount()),
            icon: Icon(Icons.logout, color: theme.colorScheme.error),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const SizeBox(height: 0.1),
            Text(s.emailSent, style: theme.textTheme.displayMedium),
            const SizeBox(height: 0.03),
            ElevatedButton(
              onPressed: () => sendEmailVerification(),
              child: Text(s.resend),
            ),
            const SizeBox(height: 0.1),
            const Loader(),
          ],
        ),
      ),
    );
  }
}
