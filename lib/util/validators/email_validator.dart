import 'package:semester_5_project_mobile_app/util/validators/regex_validator.dart';

class EmailValidator extends RegexValidator {
  EmailValidator()
      : super(
            regex:
                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
            error: 'Invalid Email');
}
