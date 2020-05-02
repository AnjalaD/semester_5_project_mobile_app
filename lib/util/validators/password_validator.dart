import 'package:semester_5_project_mobile_app/util/validators/regex_validator.dart';

class PasswordValidator extends RegexValidator {
  PasswordValidator()
      : super(
          regex: r"(?=.*[a-zA-Z])|(?=.*[0-9])",
          error: 'Must contain at least one letter, number',
        );
}
