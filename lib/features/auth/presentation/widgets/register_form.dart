import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexlock_app_v2/core/constants/colors.dart';
import 'package:nexlock_app_v2/core/validators/form_validators.dart';
import 'package:nexlock_app_v2/core/widgets/custom_text_field.dart';
import 'package:nexlock_app_v2/core/widgets/password_requirements.dart';
import 'package:nexlock_app_v2/features/auth/domain/data/providers/auth_notifier.dart';

class RegisterForm extends ConsumerStatefulWidget {
  final VoidCallback onSwitchToLogin;

  const RegisterForm({super.key, required this.onSwitchToLogin});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _showPasswordRequirements = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState?.validate() ?? false) {
      await ref
          .read(authProvider.notifier)
          .register(
            _emailController.text.trim(),
            _passwordController.text,
            _nameController.text.trim(),
          );

      // Only navigate if registration was successful
      if (mounted) {
        final authState = ref.read(authProvider);
        authState.whenData((state) {
          if ((state.isAuthenticated == true) &&
              (state.error == null || state.error!.isEmpty)) {
            context.pushReplacement('/home');
          }
          // If there's an error, stay on the register screen
        });
      }
    }
  }

  void _onPasswordChanged() {
    setState(() {
      _showPasswordRequirements = _passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = ref.watch(authProvider);
    final isLoading = authState.maybeWhen(
      data: (state) => state.isLoading,
      orElse: () => false,
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Text(
            'Create Account',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Sign up to get started with your account',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),

          // Name Field
          CustomTextField(
            label: 'Full Name',
            hint: 'Enter your full name',
            controller: _nameController,
            keyboardType: TextInputType.name,
            maxLength: 64,
            validator: FormValidators.validateName,
            enabled: !isLoading,
          ),
          const SizedBox(height: 20),

          // Email Field
          CustomTextField(
            label: 'Email Address',
            hint: 'Enter your email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            maxLength: 256,
            validator: FormValidators.validateEmail,
            enabled: !isLoading,
          ),
          const SizedBox(height: 20),

          // Password Field
          CustomTextField(
            label: 'Password',
            hint: 'Create a password',
            controller: _passwordController,
            isPassword: true,
            showPasswordToggle: true,
            maxLength: 64,
            validator: FormValidators.validatePassword,
            enabled: !isLoading,
            onChanged: _onPasswordChanged,
          ),
          const SizedBox(height: 12),

          // Password Requirements
          if (_showPasswordRequirements)
            PasswordRequirements(password: _passwordController.text),
          if (_showPasswordRequirements) const SizedBox(height: 20),

          // Confirm Password Field
          CustomTextField(
            label: 'Confirm Password',
            hint: 'Confirm your password',
            controller: _confirmPasswordController,
            isPassword: true,
            showPasswordToggle: true,
            maxLength: 64,
            validator: (value) => FormValidators.validateConfirmPassword(
              value,
              _passwordController.text,
            ),
            enabled: !isLoading,
          ),
          const SizedBox(height: 24),

          // Error Message
          authState.maybeWhen(
            data: (state) => state.error != null
                ? Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.error.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: AppColors.error,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            state.error!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            orElse: () => const SizedBox.shrink(),
          ),

          // Register Button
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: isLoading ? null : _handleRegister,
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Create Account'),
            ),
          ),
          const SizedBox(height: 24),

          // Switch to Login
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: theme.textTheme.bodyMedium,
              ),
              TextButton(
                onPressed: isLoading ? null : widget.onSwitchToLogin,
                child: const Text('Sign In'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
