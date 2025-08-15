import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmationController,
    required this.isLogin,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: 'auth-screen.email'.tr()),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(hintText: 'auth-screen.password'.tr()),
          ),
          SizedBox(height: 12),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isLogin
                ? const SizedBox(height: 55)
                : TextField(
                    controller: passwordConfirmationController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'auth-screen.confirm-password'.tr(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
