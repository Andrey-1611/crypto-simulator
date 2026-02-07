import 'package:auto_route/auto_route.dart';
import 'package:Bitmark/app/widgets/size_box.dart';
import 'package:Bitmark/features/auth/widgets/google_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/router/app_router.dart';
import '../../../core/utils/dialog_helper.dart';
import '../../../core/utils/toast_helper.dart';
import '../../../core/utils/validator.dart';
import '../providers/auth_provider.dart';
import '../widgets/form_text_field.dart';

@RoutePage()
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;

  void signUp() async {
    if (formKey.currentState!.validate()) {
      await ref
          .read(authNotifierProvider.notifier)
          .signUp(
            nameController.text.trim(),
            emailController.text.trim(),
            passwordController.text.trim(),
          );
    }
  }

  @override
  void initState() {
    super.initState();
    ref.listenManual(authNotifierProvider, (_, state) {
      state.when(
        loading: () => DialogHelper.loading(context),
        data: (_) => context.pushRoute(const HomeRoute()),
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
                      controller: nameController,
                      validator: Validator.name,
                      hintText: 'Имя',
                      icon: const Icon(Icons.person),
                    ),
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
                        onPressed: () => signUp(),
                        child: const Text('Зарегистрироваться'),
                      ),
                    ),
                  ],
                ),
              ),
              const GoogleButton(),
              const Spacer(),
              TextButton(
                onPressed: () => context.pushRoute(const SignInRoute()),
                child: const Text('Уже есть аккаунт?  Войти в аккаунт'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
