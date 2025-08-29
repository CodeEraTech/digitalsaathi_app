class FormValidation{

  String? _validateName(String? value) {
    // Regular expression for name validation (only letters and spaces)
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    } else if (!nameRegExp.hasMatch(value)) {
      return 'Please enter a valid name (letters and spaces only)';
    }
    return null; // Return null if validation passes
  }

}