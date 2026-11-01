import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'login_button.dart';
import 'login_field.dart';

typedef LoginCallback =
    Future<void> Function({required String email, required String password});

class LoginCard extends StatefulWidget {
  const LoginCard({
    super.key,
    required this.onLogin,
    required this.isLoading,
    required this.errorMessage,
  });

  final LoginCallback onLogin;
  final bool isLoading;
  final String? errorMessage;

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateIdentifier(String? value) {
    final identifier = value?.trim() ?? '';

    if (identifier.isEmpty) {
      return 'Enter your institutional ID or email';
    }

    if (identifier.contains('@') &&
        !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(identifier)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your password';
    }

    return null;
  }

  Future<void> _handleSignIn() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    FocusScope.of(context).unfocus();

    await widget.onLogin(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final errorMessage = widget.errorMessage;
    const labelStyle = TextStyle(
      fontSize: 15.5,
      fontWeight: FontWeight.w700,
      color: AppColors.navy,
    );

    return Form(
      key: _formKey,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 30,
              offset: Offset(0, 14),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome back',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                color: AppColors.navy,
                letterSpacing: -0.8,
              ),
            ),
            const SizedBox(height: 32),
            const Text('Institutional ID or Email', style: labelStyle),
            const SizedBox(height: 10),
            LoginField(
              controller: _emailController,
              validator: _validateIdentifier,
              hint: 'e.g. admin@campus.edu',
              icon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.username],
              textInputAction: TextInputAction.next,
              suffix: const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Text(
                  '⌘K',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.muted,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                const Text('Password', style: labelStyle),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LoginField(
              controller: _passwordController,
              validator: _validatePassword,
              hint: '••••••••••••••',
              icon: Icons.vpn_key_outlined,
              obscureText: _obscurePassword,
              autofillHints: const [AutofillHints.password],
              textInputAction: TextInputAction.done,
              suffix: IconButton(
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 20,
                  color: AppColors.muted,
                ),
                splashRadius: 20,
                tooltip: _obscurePassword ? 'Show password' : 'Hide password',
              ),
            ),
            const SizedBox(height: 18),
            if (errorMessage != null) ...[
              Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.5,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              const SizedBox(height: 12),
            ],
            LoginButton(onPressed: _handleSignIn, isLoading: widget.isLoading),
          ],
        ),
      ),
    );
  }
}
