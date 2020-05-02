import 'package:semester_5_project_mobile_app/util/validators/regex_validator.dart';

class NicValidator extends RegexValidator {
  NicValidator()
      : super(
          regex: r"^[0-9]{9}(v|V|x)$|^[0-9]{11}$",
          error: 'Invalid nic',
        );
}
