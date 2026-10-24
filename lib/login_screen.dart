import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'core/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 32,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const BrandHeader(),
                        const SizedBox(height: 26),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 440),
                          child: const LoginCard(),
                        ),
                        const SizedBox(height: 20),
                        const ComplianceNote(),
                        const SizedBox(height: 7),
                        const AssistanceNote(),
                        const SizedBox(height: 48),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 620),
                          child: const Footer(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BrandLogo(),
            SizedBox(width: 10),
            Text(
              'Campus Presence',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
                color: AppColors.navy,
                letterSpacing: -0.6,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'SMART ATTENDANCE OS',
          style: TextStyle(
            fontSize: 8.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.4,
            color: AppColors.muted,
          ),
        ),
      ],
    );
  }
}

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(Icons.graphic_eq, color: AppColors.white, size: 21),
    );
  }
}

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 36,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Welcome back',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: AppColors.navy,
              letterSpacing: -0.6,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Enter your institutional credentials to access your portal',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.45,
              color: AppColors.muted,
            ),
          ),
          SizedBox(height: 22),
          PortalToggle(),
          SizedBox(height: 22),
          FieldLabel('Institutional ID or Email'),
          SizedBox(height: 8),
          LoginField(hint: 'e.g. STF/2024/001', icon: Icons.badge_outlined),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: FieldLabel('Password')),
              ForgotPasswordButton(),
            ],
          ),
          SizedBox(height: 8),
          LoginField(
            hint: '••••••••',
            icon: Icons.lock_outline,
            obscureText: true,
            suffixIcon: Icon(
              Icons.visibility_off_outlined,
              size: 18,
              color: AppColors.muted,
            ),
          ),
          SizedBox(height: 14),
          KeepSignedIn(),
          SizedBox(height: 20),
          SignInButton(),
          SizedBox(height: 20),
          OrDivider(),
          SizedBox(height: 16),
          SsoButton(),
          SizedBox(height: 18),
          Biometrics(),
        ],
      ),
    );
  }
}

class PortalToggle extends StatelessWidget {
  const PortalToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.canvas,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          PortalTab(
            icon: Icons.badge_outlined,
            label: 'Admin / Faculty',
            selected: true,
          ),
          PortalTab(
            icon: Icons.school_outlined,
            label: 'Student Portal',
            selected: false,
          ),
        ],
      ),
    );
  }
}

class PortalTab extends StatelessWidget {
  const PortalTab({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
  });

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: selected
          ? BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(9),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 15,
            color: selected ? AppColors.primary : AppColors.muted,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: selected ? AppColors.navy : AppColors.muted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        color: AppColors.navy,
      ),
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: AppColors.primary,
      ),
      child: const Text(
        'Forgot password?',
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class LoginField extends StatelessWidget {
  const LoginField({
    super.key,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
  });

  final String hint;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      style: TextStyle(
        fontSize: 13,
        color: AppColors.navy,
        letterSpacing: obscureText ? 2 : null,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.muted, fontSize: 12.5),
        prefixIcon: Icon(icon, size: 18, color: AppColors.muted),
        prefixIconConstraints: const BoxConstraints(minWidth: 44),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        filled: true,
        fillColor: AppColors.white,
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}

class KeepSignedIn extends StatelessWidget {
  const KeepSignedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: SizedBox(
            width: 16,
            height: 16,
            child: Icon(Icons.check, size: 12, color: AppColors.white),
          ),
        ),
        SizedBox(width: 8),
        Text(
          'Keep me signed in for 30 days',
          style: TextStyle(fontSize: 11.5, color: AppColors.muted),
        ),
      ],
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.login, size: 18),
            SizedBox(width: 8),
            Text(
              'Sign In',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.border, height: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'or continue with',
            style: TextStyle(fontSize: 11, color: AppColors.muted),
          ),
        ),
        Expanded(child: Divider(color: AppColors.border, height: 1)),
      ],
    );
  }
}

class SsoButton extends StatelessWidget {
  const SsoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.white,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Ionicons.logo_google, size: 18, color: AppColors.navy),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                'Sign in with Campus SSO / Google',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.navy,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Biometrics extends StatelessWidget {
  const Biometrics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.fingerprint, size: 19, color: AppColors.muted),
        SizedBox(width: 8),
        Flexible(
          child: Text(
            'Authenticate using Device Biometrics',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.muted,
            ),
          ),
        ),
      ],
    );
  }
}

class ComplianceNote extends StatelessWidget {
  const ComplianceNote({super.key});

  @override
  Widget build(BuildContext context) {
    return const FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified_user_outlined, size: 12, color: AppColors.muted),
          SizedBox(width: 4),
          Text(
            'FEDERAL Compliant',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
              color: AppColors.muted,
            ),
          ),
          Text(
            '   •   ',
            style: TextStyle(fontSize: 10, color: AppColors.muted),
          ),
          Icon(Icons.lock_outline, size: 11, color: AppColors.muted),
          SizedBox(width: 3),
          Text(
            'AES-256 SSL Encrypted',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
              color: AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class AssistanceNote extends StatelessWidget {
  const AssistanceNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      const TextSpan(
        children: [
          TextSpan(
            text: 'Need assistance? ',
            style: TextStyle(fontSize: 11, color: AppColors.muted),
          ),
          TextSpan(
            text: 'Contact Campus IT Helpdesk',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          TextSpan(
            text: ' or dial ext. 4400.',
            style: TextStyle(fontSize: 11, color: AppColors.muted),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '© 2025 Campus Presence',
          style: TextStyle(fontSize: 10.5, color: AppColors.muted),
        ),
        Row(
          children: [
            Text(
              'Terms',
              style: TextStyle(fontSize: 10.5, color: AppColors.muted),
            ),
            SizedBox(width: 18),
            Text(
              'Privacy',
              style: TextStyle(fontSize: 10.5, color: AppColors.muted),
            ),
            SizedBox(width: 18),
            Text(
              'Helpdesk',
              style: TextStyle(fontSize: 10.5, color: AppColors.muted),
            ),
          ],
        ),
      ],
    );
  }
}
