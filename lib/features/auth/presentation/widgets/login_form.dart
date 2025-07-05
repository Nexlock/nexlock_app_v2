import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexlock_app_v2/core/constants/colors.dart';
import 'package:nexlock_app_v2/core/validators/form_validators.dart';
import 'package:nexlock_app_v2/core/widgets/custom_text_field.dart';
import 'package:nexlock_app_v2/features/auth/domain/data/providers/auth_notifier.dart';

class LoginForm extends ConsumerStatefulWidget {
  final VoidCallback onSwitchToRegister;

  const LoginForm({super.key, required this.onSwitchToRegister});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      await ref
          .read(authProvider.notifier)
          .login(_emailController.text.trim(), _passwordController.text);
    }
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
            'Welcome Back',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Sign in to your account to continue',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),

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
            hint: 'Enter your password',
            controller: _passwordController,
            isPassword: true,
            showPasswordToggle: true,
            maxLength: 64,
            validator: FormValidators.validatePassword,
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

          // Login Button
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: isLoading ? null : _handleLogin,
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Sign In'),
            ),
          ),
          const SizedBox(height: 24),

          // Switch to Register
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: theme.textTheme.bodyMedium,
              ),
              TextButton(
                onPressed: isLoading ? null : widget.onSwitchToRegister,
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
