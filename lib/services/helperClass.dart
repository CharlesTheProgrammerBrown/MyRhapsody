class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _fullNameRegExp = RegExp(
    r"^[a-zA-Z'-\s\.]{3,20}\s[a-zA-Z'-\.]{3,20}$",
  );

  static bool isValidEmail(String emailStr) {
    return _emailRegExp.hasMatch(emailStr);
  }

  static bool isValidPassword(String passwordStr) {
    if (passwordStr.length > 5) {
      return true;
    } else {
      return false;
    } //_passwordRegExp.hasMatch(passwordStr);
  }

  static bool isValidName(String nameStr) {
    return _fullNameRegExp.hasMatch(nameStr);
  }
}
