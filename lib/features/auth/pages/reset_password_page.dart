import 'package:auto_route/auto_route.dart';
import 'package:Bitmark/app/widgets/size_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/toast_helper.dart';
import '../../../core/utils/validator.dart';
import '../providers/auth_provider.dart';
import '../widgets/form_text_field.dart';

@RoutePage()
class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ConsumerState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void resetPassword() async {
    if (formKey.currentState!.validate()) {
      await ref
          .read(authNotifierProvider.notifier)
          .sendPasswordResetEmail(emailController.text.trim());
    }
  }

  @override
  void initState() {
    super.initState();
    ref.listenManual(authNotifierProvider, (_, state) {
      state.when(
        loading: () {},
        data: (_) {
          context.pop();
          context.pop();
          ToastHelper.success();
        },
        error: (_, _) {
          context.pop();
          ToastHelper.unknownError();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Сброс пароля')),
      body: Padding(
        padding: const .all(32),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: .center,
              children: [
                FormTextField(
                  controller: emailController,
                  validator: Validator.email,
                  hintText: 'Почта',
                  icon: const Icon(Icons.email),
                ),
                const SizeBox(height: 0.01),
                SizeBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => resetPassword(),
                    child: const Text('Подтвердить'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
