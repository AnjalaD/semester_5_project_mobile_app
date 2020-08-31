import 'package:semester_5_project_mobile_app/util/validators/regex_validator.dart';

class DateValidator extends RegexValidator {
  DateValidator()
      : super(
            regex:
                r"(19|20)[0-9]{2}-(0|1)[0-9]-(0|1|2|3)[0-9]",
            error: 'Use format yyyy-mm-dd');
}
