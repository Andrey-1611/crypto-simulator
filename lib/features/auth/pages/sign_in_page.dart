import 'package:auto_route/auto_route.dart';
import 'package:crypto_simulator/app/router/app_router.dart';
import 'package:crypto_simulator/core/utils/dialog_helper.dart';
import 'package:crypto_simulator/core/utils/toast_helper.dart';
import 'package:crypto_simulator/core/utils/validator.dart';
import 'package:crypto_simulator/features/auth/providers/auth_provider.dart';
import 'package:crypto_simulator/features/auth/widgets/form_text_field.dart';
import 'package:crypto_simulator/features/auth/widgets/google_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/widgets/size_box.dart';

@RoutePage()
class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isObscure = true;

  void signIn() async {
    if (formKey.currentState!.validate()) {
      await ref
          .read(authNotifierProvider.notifier)
          .signIn(emailController.text.trim(), passwordController.text.trim());
    }
  }

  @override
  void initState() {
    super.initState();
    ref.listenManual(authNotifierProvider, (_, state) {
      state.when(
        loading: () => DialogHelper.loading(context),
        data: (isAuth) {
          context.pop();
          context.replaceRoute(const HomeRoute());
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
    return Scaffold(
      body: Padding(
        padding: const .all(32),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              Form(
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
                    FormTextField(
                      controller: passwordController,
                      validator: Validator.password,
                      hintText: 'Пароль',
                      icon: const Icon(Icons.key),
                      isObscure: isObscure,
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          isObscure = !isObscure;
                        }),
                        icon: const Icon(Icons.remove_red_eye_outlined),
                      ),
                    ),
                    const SizeBox(height: 0.02),
                    SizeBox(
                      width: 1,
                      height: 0.05,
                      child: ElevatedButton(
                        onPressed: () => signIn(),
                        child: const Text('Войти'),
                      ),
                    ),
                  ],
                ),
              ),
              const GoogleButton(),
              const Spacer(),
              TextButton(
                onPressed: () => context.pushRoute(const SignUpRoute()),
                child: const Text('Еще нет аккаунта?  Создать аккаунт'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}