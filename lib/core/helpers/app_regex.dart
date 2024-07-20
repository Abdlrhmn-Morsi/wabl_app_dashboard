import 'package:easy_localization/easy_localization.dart';

class AppRegex {
  static String? checkFullName(String? value) {
    String? message;

    // if (value!.split(' ').length < 3) {
    //   message = 'Please enter full name in 3 words';
    // }
    if (value!.length < 4) {
      message = 'name_cannot_be_less_than_4_characters'.tr();
    }
    if (value.isEmpty) {
      message = 'filed_cannot_be_empty'.tr();
    }
    return message;
  }

  static String? checkNotEmpty(String? value) {
    String? message;
    if (value!.isEmpty) {
      message = 'filed_cannot_be_empty'.tr();
    }
    return message;
  }

  static String? emailValidation(String? value) {
    RegExp emailRegex = RegExp(r'^\w+@gmail\.com$');
    String? message;
    if (!emailRegex.hasMatch(value!)) {
      message = '${'invalid_email'.tr()} @gmail.com';
    }
    if (value.isEmpty) {
      message = 'filed_cannot_be_empty'.tr();
    }
    return message;
  }

  static String? passwordValidation(String? value) {
    // String subMessage = "Password should has at least one";
    String? message;

    if (!hasMinLength(value!)) {
      message = 'password_can_not_be_less_that_8_characters'.tr();
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
      message = 'filed_cannot_be_empty'.tr();
    }
    return message;
  }

  static String? confirmationPasswordValidation({
    required String password,
    String? confirmPassword,
  }) {
    String? message;
    if (password != confirmPassword) {
      message = 'not_matched_with_password'.tr();
    }
    if (confirmPassword!.isEmpty) {
      message = 'please_confirm_your_password'.tr();
    }
    return message;
  }

  static String? phoneNumberValidation(String? value) {
    String? message;
    if (!isPhoneNumberValid(value!)) {
      message = 'please_enter_valid_phone_number'.tr();
    }
    if (value.isEmpty) {
      message = 'filed_cannot_be_empty'.tr();
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
