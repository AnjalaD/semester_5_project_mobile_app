import 'package:semester_5_project_mobile_app/util/validators/regex_validator.dart';

class TelephoneValidator extends RegexValidator {
  TelephoneValidator()
      : super(
          regex: r"^0[0-9]{9}$",
          error: 'Invalid telephone number',
        );
}
