import 'package:flutter/foundation.dart';
import 'package:semester_5_project_mobile_app/util/validators/base_validator.dart';

class RegexValidator extends BaseValidator {
  final String regex;
  final String error;
  RegexValidator({@required this.regex, @required this.error}) : super(error);

  @override
  validate() {
    if (RegExp(regex).hasMatch(this.input)) {
      return true;
    }
    return false;
  }
}
