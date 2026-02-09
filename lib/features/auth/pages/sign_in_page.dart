import 'package:auto_route/auto_route.dart';
import 'package:Bitmark/app/router/app_router.dart';
import 'package:Bitmark/core/utils/toast_helper.dart';
import 'package:Bitmark/core/utils/validator.dart';
import 'package:Bitmark/features/auth/providers/auth_provider.dart';
import 'package:Bitmark/features/auth/widgets/form_text_field.dart';
import 'package:Bitmark/features/auth/widgets/google_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/widgets/size_box.dart';
import '../../../generated/l10n.dart';

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
        loading: () {},
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
    final s = S.of(context);
    return Scaffold(
      body: Padding(
        padding: .all(32.sp),
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
                      hintText: s.email,
                      icon: const Icon(Icons.email),
                    ),
                    FormTextField(
                      controller: passwordController,
                      validator: Validator.password,
                      hintText: s.password,
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
                        child: Text(s.signIn),
                      ),
                    ),
                    const SizeBox(height: 0.01),
                    TextButton(
                      onPressed: () =>
                          context.pushRoute(const ResetPasswordRoute()),
                      child: Text(s.forgotPassword),
                    ),
                  ],
                ),
              ),
              const GoogleButton(),
              const Spacer(),
              TextButton(
                onPressed: () => context.pushRoute(const SignUpRoute()),
                child: Text(s.noAccount),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
