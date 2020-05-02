import 'package:semester_5_project_mobile_app/util/validators/base_validator.dart';

typedef FormValidator = String Function(String value);

class Validator {
  static FormValidator validator(List<BaseValidator> validators) {
    return (String value) {
      for (var validator in validators) {
        validator.setInput(value);

        if (!validator.validate()) {
          return validator.error;
        }
      }
      return null;
    };
  }
}
