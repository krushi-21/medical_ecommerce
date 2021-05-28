class Validations {
  static String validateName(String value) {
    if (value.isEmpty || value.length < 4)
      return 'Name Must be contains 4 letters';
    final RegExp nameExp = new RegExp(r'^(?!.\.\.)(?!.\.$)[^\W][\w.]{0,20}$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

  static String validateEmail(String value) {
    if (value.isEmpty) return 'Please enter an Email Address.';
    final RegExp nameExp = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,2"
        r"53}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-z"
        r"A-Z0-9])?)*$");
    if (!nameExp.hasMatch(value)) return 'Invalid email address';
    return null;
  }

  static String validateDescription(String value) {
    if (value.isEmpty || value.length < 24)
      return 'Description Must be contains 4 letters.';
    return null;
  }

  static String validatePrice(String value) {
    if (value.isEmpty || value.length < 1) return 'Please enter a valid Price.';
    return null;
  }

  static String validateGstNumber(String value) {
    if (value.isEmpty || value.length < 1) return 'Please enter a valid Price.';
    final RegExp gstExp = new RegExp(r"[A-Z]{5}[0-9]{4}[A-Z]{1}");
    if (!gstExp.hasMatch(value)) return 'Invalid phone nimber';
    return null;
  }

  static String validatePanNumber(String value) {
    if (value.isEmpty || value.length < 1) return 'Please enter a valid Price.';
    final RegExp panExp =
        new RegExp(r"\d{2}[A-Z]{5}\d{4}[A-Z]{1}[A-Z\d]{1}[Z]{1}[A-Z\d]{1}");
    if (!panExp.hasMatch(value)) return 'Invalid phone nimber';
    return null;
  }

  static String validatePhoneNumber(String value) {
    if (value.isEmpty || value.length < 1) return 'Please enter a valid Price.';
    final RegExp phoneExp = new RegExp(r"^(\+91[\-\s]?)?[0]?(91)?[789]\d{9}$");
    if (!phoneExp.hasMatch(value)) return 'Invalid phone nimber';
    return null;
  }

  static String validatePassword(String value) {
    if (value.isEmpty || value.length < 6)
      return 'Please enter a valid password.';
    return null;
  }
}
