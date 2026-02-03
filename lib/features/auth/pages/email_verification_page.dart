import 'package:auto_route/auto_route.dart';
import 'package:crypto_simulator/app/router/app_router.dart';
import 'package:crypto_simulator/app/widgets/loader.dart';
import 'package:crypto_simulator/core/utils/toast_helper.dart';
import 'package:crypto_simulator/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/widgets/size_box.dart';
import '../../../core/utils/dialog_helper.dart';

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
    //sendEmailVerification();
    ref.listenManual(authNotifierProvider, (_, state) {
      state.when(
        data: (_) => context.pushRoute(const HomeRoute()),
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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Подтверждение почты'),
        actions: [
          IconButton(
            onPressed: () =>
                DialogHelper.signOut(context, () => deleteAccount()),
            icon: Icon(Icons.logout, color: theme.colorScheme.error),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: .center,
        children: [
          const SizeBox(height: 0.18),
          Text(
            'Пиcьмо отправлено на вашу почту',
            style: theme.textTheme.displayMedium,
          ),
          const SizeBox(height: 0.03),
          ElevatedButton(
            onPressed: () => sendEmailVerification(),
            child: const Text('Отправить повторно'),
          ),
          const SizeBox(height: 0.01),
          ElevatedButton(
            onPressed: () => checkEmailVerification(),
            child: const Text('Проверить'),
          ),
          const SizeBox(height: 0.2),
          const Loader(),
        ],
      ),
    );
  }
}
