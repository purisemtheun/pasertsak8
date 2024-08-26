import 'package:flutter/widgets.dart';

class Validators {
  // Validator to check if a field is required
  static FormFieldValidator<String> required(String errorMessage) {
    return (value) {
      if (value == null || value.isEmpty) {
        return errorMessage;
      }
      return null;
    };
  }

  // Validator to check if a field's value is greater than or equal to a minimum value
  static FormFieldValidator<String> min(double min, String errorMessage) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return null;
      }
      if (value.startsWith('.') ||
          value.startsWith('-') ||
          value.endsWith('-') ||
          value.endsWith('.') ||
          value.contains('-')) {
        return 'Invalid numeric pattern!';
      }
      final dValue = double.tryParse(value);
      if (dValue == null || dValue < min) {
        return errorMessage;
      }
      return null;
    };
  }

  // Validator to compose multiple validators
  static FormFieldValidator<String> compose(List<FormFieldValidator<String>> validators) {
    return (value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }
}
