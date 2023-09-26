class TextFormFieldValidations {
  static bool isEmpty(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  static bool containsCharacters(String value) {
    if (value.contains(RegExp(r'^[a-zA-Z]+$'))) {
      return true;
    }
    return false;
  }

  static bool isValidEmail(String value) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
  }

  static bool passwordHasTheMinimalCharacters(String value) {
      if (value.length >= 8) {
      return true;
    }
    return false;
  }
}
