class Validators {
  //name validator
  static String? validatename(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    final nameregp = RegExp(r"^[a-zA-Z\s'-]+$");
    if (!nameregp.hasMatch(value.trim())) {
      return "Enter a valid name";
    }
    if (value.trim().length < 2) {
      return "Name is too short";
    }
    return null;
  }

  //email validator
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email id';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email id";
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter phone number";
    }
    if (value.length < 10 || value.length > 10) {
      return "Phone number should be 10 digits";
    }
    return null;
  }

  //age validator
  static String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your age';
    }
    final age = int.tryParse(value);
    if (age == null || age <= 0) {
      return 'Enter a valid age';
    }
    return null;
  }

  //place validator
  static String? validatePlace(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a place';
    }
    final placeRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!placeRegExp.hasMatch(value)) {
      return 'Place should contain only letters';
    }
    return null;
  }

  //password validator
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must be at least 8 characters,\ninclude upper and lower case letters,\na number and a special character.';
    }
    return null;
  }

  //comfirmpassword validator
  static String? validateConfirmPassword(
    String? value,
    String originalPassword,
  ) {
    if (value == null || value.isEmpty) {
      return "Confirm Password is required";
    }
    if (value != originalPassword) {
      return "Passwords do not match";
    }
    return validatePassword(value);
  }
}
