import 'package:semester_5_project_mobile_app/util/validators/regex_validator.dart';

class NicValidator extends RegexValidator {
  NicValidator()
      : super(
          regex: r"^[0-9]{9}(v|V|x|X)$|^[0-9]{12}$",
          error: 'Invalid nic',
        );
}
