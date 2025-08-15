import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hackathon_google/core/extensions/theme_extension.dart';
import 'package:hackathon_google/features/auth_screen/widgets/auth_form.dart';
import 'package:hackathon_google/shared/themed_background/themed_background.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  bool isLoading = false;
  String? errorMessage;

  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;

  Future<fb.User?> _signIn(String email, String password) async {
    print('[AuthService] Attempting sign in with email: $email');
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print('[AuthService] Sign in success. UID: ${credential.user?.uid}');
    return credential.user;
  }

  Future<fb.User?> _signUp(String email, String password) async {
    print('[AuthService] Attempting sign up with email: $email');
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print('[AuthService] Sign up success. UID: ${credential.user?.uid}');
    return credential.user;
  }

  Future<void> _signOut() async {
    print('[AuthService] Signing out...');
    await _auth.signOut();
    print('[AuthService] Signed out successfully.');
  }

  Future<void> _submit() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      if (isLogin) {
        await _signIn(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
      } else {
        if (passwordController.text.trim() !=
            passwordConfirmationController.text.trim()) {
          throw Exception('Passwords do not match');
        }
        await _signUp(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
      }
    } catch (e) {
      print('[AuthService] Error: $e');
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isLogin ? 'auth-screen.login'.tr() : 'auth-screen.register'.tr(),
        ),
        actions: [
          if (_auth.currentUser != null)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                _signOut();
                setState(() {});
              },
            ),
        ],
      ),
      body: ThemedBackground(
        dialate: 2,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoSegmentedControl<bool>(
                  unselectedColor: context.colors.secondary,
                  groupValue: isLogin,
                  children: {
                    true: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'auth-screen.login'.tr(),
                        style: TextStyle(color: context.colors.onPrimary),
                      ),
                    ),
                    false: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'auth-screen.register'.tr(),
                        style: TextStyle(color: context.colors.onPrimary),
                      ),
                    ),
                  },
                  onValueChanged: (value) {
                    setState(() {
                      isLogin = value;
                      errorMessage = null;
                    });
                    print(
                      '[AuthUI] Mode changed to: ${isLogin ? "Login" : "Register"}',
                    );
                  },
                ),
                const SizedBox(height: 24),
                AuthForm(
                  emailController: emailController,
                  passwordController: passwordController,
                  passwordConfirmationController:
                      passwordConfirmationController,
                  isLogin: isLogin,
                ),
                if (errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: CupertinoColors.systemRed),
                  ),
                ],
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colors.primary,
                    shadowColor: Colors.grey,
                  ),
                  onPressed: _submit,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: isLoading
                        ? const CupertinoActivityIndicator()
                        : Text(
                            isLogin
                                ? 'auth-screen.login'.tr()
                                : 'auth-screen.register'.tr(),
                            style: TextStyle(color: context.colors.onPrimary),
                          ),
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
