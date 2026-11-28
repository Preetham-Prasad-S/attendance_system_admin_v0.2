import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/dependency_injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../controller/auth_state.dart';
import '../widgets/login_button.dart';
import '../widgets/login_field.dart';

class RegisterUserScreen extends ConsumerStatefulWidget {
  const RegisterUserScreen({super.key, this.email = ''});

  final String email;

  @override
  ConsumerState<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends ConsumerState<RegisterUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmation = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  void didUpdateWidget(covariant RegisterUserScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.email != oldWidget.email) {
      _emailController.text = widget.email;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Enter your institutional email';
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter a password';
    }
    if (value.length < 6) {
      return 'Use at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> _handleCheckEmail() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    FocusScope.of(context).unfocus();

    await ref
        .read(authControllerProvider.notifier)
        .checkRegistrationEmail(_emailController.text.trim());
  }

  Future<void> _handleRegister() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    FocusScope.of(context).unfocus();

    await ref
        .read(authControllerProvider.notifier)
        .register(password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isPasswordStep = authState is AuthRegistrationRequired;

    final errorMessage = switch (authState) {
      AuthRegistrationStarted(:final errorMessage) => errorMessage,
      AuthRegistrationRequired(:final errorMessage) => errorMessage,
      _ => null,
    };
    final isLoading = switch (authState) {
      AuthRegistrationStarted(:final isCheckingEmail) => isCheckingEmail,
      AuthRegistrationRequired(:final isSubmitting) => isSubmitting,
      _ => false,
    };

    final title = isPasswordStep
        ? 'Complete registration'
        : 'Register new admin';
    final description = isPasswordStep
        ? 'Set a password to activate your admin account.'
        : 'Enter the institutional email added for your admin account.';

    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 48, 20, 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Column(
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.school_rounded,
                          color: AppColors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'CampusPresence',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          color: AppColors.brand,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 56),
                Form(
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
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w800,
                            color: AppColors.navy,
                            letterSpacing: -0.6,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: AppColors.mutedStrong,
                          ),
                        ),
                        const SizedBox(height: 28),
                        const Text(
                          'Institutional email',
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.navy,
                          ),
                        ),
                        const SizedBox(height: 10),
                        LoginField(
                          controller: _emailController,
                          validator: _validateEmail,
                          hint: 'e.g. admin@campus.edu',
                          icon: Icons.mail_outline_rounded,
                          readOnly: isPasswordStep,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: isPasswordStep
                              ? null
                              : const [AutofillHints.username],
                          textInputAction: isPasswordStep
                              ? TextInputAction.done
                              : TextInputAction.next,
                        ),
                        if (isPasswordStep) ...[
                          const SizedBox(height: 18),
                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.navy,
                            ),
                          ),
                          const SizedBox(height: 10),
                          LoginField(
                            controller: _passwordController,
                            validator: _validatePassword,
                            hint: '••••••••••••••',
                            icon: Icons.vpn_key_outlined,
                            obscureText: _obscurePassword,
                            autofillHints: const [AutofillHints.newPassword],
                            textInputAction: TextInputAction.next,
                            suffix: IconButton(
                              onPressed: () {
                                setState(
                                  () => _obscurePassword = !_obscurePassword,
                                );
                              },
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                size: 20,
                                color: AppColors.muted,
                              ),
                              splashRadius: 20,
                              tooltip: _obscurePassword
                                  ? 'Show password'
                                  : 'Hide password',
                            ),
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            'Confirm password',
                            style: TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.navy,
                            ),
                          ),
                          const SizedBox(height: 10),
                          LoginField(
                            controller: _confirmPasswordController,
                            validator: _validateConfirmation,
                            hint: '••••••••••••••',
                            icon: Icons.vpn_key_outlined,
                            obscureText: _obscureConfirmation,
                            textInputAction: TextInputAction.done,
                            suffix: IconButton(
                              onPressed: () {
                                setState(
                                  () => _obscureConfirmation =
                                      !_obscureConfirmation,
                                );
                              },
                              icon: Icon(
                                _obscureConfirmation
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                size: 20,
                                color: AppColors.muted,
                              ),
                              splashRadius: 20,
                              tooltip: _obscureConfirmation
                                  ? 'Show password'
                                  : 'Hide password',
                            ),
                          ),
                        ],
                        if (errorMessage != null) ...[
                          const SizedBox(height: 18),
                          Text(
                            errorMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13.5,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ],
                        const SizedBox(height: 22),
                        LoginButton(
                          onPressed: isPasswordStep
                              ? _handleRegister
                              : _handleCheckEmail,
                          isLoading: isLoading,
                          label: isPasswordStep
                              ? 'Create Account'
                              : 'Check Email',
                          icon: isPasswordStep
                              ? Icons.person_add_alt_1_rounded
                              : Icons.search_rounded,
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            ref
                                .read(authControllerProvider.notifier)
                                .cancelRegistration();
                          },
                          child: const Text('Back to sign in'),
                        ),
                      ],
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
