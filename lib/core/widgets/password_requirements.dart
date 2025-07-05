import 'package:flutter/material.dart';
import 'package:nexlock_app_v2/core/constants/colors.dart';
import 'package:nexlock_app_v2/core/validators/form_validators.dart';

class PasswordRequirements extends StatelessWidget {
  final String password;

  const PasswordRequirements({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final requirements = FormValidators.getPasswordRequirements(password);

    if (password.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password Requirements:',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          ...requirements.map(
            (requirement) => _buildRequirementItem(context, requirement, false),
          ),
          ..._getMetRequirements(password).map(
            (requirement) => _buildRequirementItem(context, requirement, true),
          ),
        ],
      ),
    );
  }

  List<String> _getMetRequirements(String password) {
    final allRequirements = [
      'At least 8 characters',
      'One uppercase letter',
      'One lowercase letter',
      'One number',
      'One special character',
    ];

    final unmetRequirements = FormValidators.getPasswordRequirements(password);
    return allRequirements
        .where((req) => !unmetRequirements.contains(req))
        .toList();
  }

  Widget _buildRequirementItem(
    BuildContext context,
    String requirement,
    bool isMet,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: isMet
                ? AppColors.success
                : theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Text(
            requirement,
            style: theme.textTheme.bodySmall?.copyWith(
              color: isMet
                  ? AppColors.success
                  : theme.colorScheme.onSurfaceVariant,
              decoration: isMet ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    );
  }
}
