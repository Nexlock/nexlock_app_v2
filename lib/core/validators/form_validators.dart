class FormValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    if (value.length > 256) {
      return 'Email must be less than 256 characters';
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }

    if (value.length > 64) {
      return 'Name must be less than 64 characters';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (value.length > 64) {
      return 'Password must be less than 64 characters';
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  static List<String> getPasswordRequirements(String password) {
    final requirements = <String>[];

    if (password.length < 8) {
      requirements.add('At least 8 characters');
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      requirements.add('One uppercase letter');
    }

    if (!RegExp(r'[a-z]').hasMatch(password)) {
      requirements.add('One lowercase letter');
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      requirements.add('One number');
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      requirements.add('One special character');
    }

    return requirements;
  }
}
