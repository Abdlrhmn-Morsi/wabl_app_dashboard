class AppRegex {
  static String? checkFullName(String? value) {
    String? message;

    if (value!.split(' ').length < 3) {
      message = 'Please enter full name in 3 words';
    }
    if (value.isEmpty) {
      message = 'Please enter name';
    }
    return message;
  }

  static String? emailValidation(String? value) {
    RegExp emailRegex = RegExp(r'^\w+@gmail\.com$');
    String? message;
    if (!emailRegex.hasMatch(value!)) {
      message = 'Email should be like name@gmail.com';
    }
    if (value.isEmpty) {
      message = 'Please enter email';
    }
    return message;
  }

  static String? passwordValidation(String? value) {
    // String subMessage = "Password should has at least one";
    String? message;

    if (!hasMinLength(value!)) {
      message = 'Password can not be less that 8 characters';
    }
    // if (!hasSpecialCharacter(value)) {
    //   message = '$subMessage special character';
    // }
    // if (!hasNumber(value)) {
    //   message = '$subMessage number';
    // }
    // if (!hasUpperCase(value)) {
    //   message = '$subMessage UpperCase';
    // }
    // if (!hasLowerCase(value)) {
    //   message = '$subMessage lowerCase';
    // }
    if (value.isEmpty) {
      message = 'Please enter password';
    }
    return message;
  }

  static String? confirmationPasswordValidation({
    required String password,
    String? confirmPassword,
  }) {
    String? message;
    if (password != confirmPassword) {
      message = 'not matched with password';
    }
    if (confirmPassword!.isEmpty) {
      message = 'Please confirm your password';
    }
    return message;
  }

  static String? phoneNumberValidation(String? value) {
    String? message;
    if (!isPhoneNumberValid(value!)) {
      message = 'Please enter valid phone number';
    }
    if (value.isEmpty) {
      message = 'Please enter phone number';
    }
    return message;
  }

  static bool isEGPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^(010|011|012|015)[0-9]{8}$').hasMatch(phoneNumber);
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^\d{8,15}$').hasMatch(phoneNumber);
  }

  static bool hasLowerCase(String password) {
    return RegExp(r'^(?=.*[a-z])').hasMatch(password);
  }

  static bool hasUpperCase(String password) {
    return RegExp(r'^(?=.*[A-Z])').hasMatch(password);
  }

  static bool hasNumber(String password) {
    return RegExp(r'^(?=.*?[0-9])').hasMatch(password);
  }

  static bool hasSpecialCharacter(String password) {
    return RegExp(r'^(?=.*?[#?!@$%^&*-])').hasMatch(password);
  }

  static bool hasMinLength(String password) {
    return RegExp(r'^(?=.{8,})').hasMatch(password);
  }

  static bool isPasswordValid(String password) {
    return RegExp(
            r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
        .hasMatch(password);
  }

  static bool isEmailValid(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }
}
