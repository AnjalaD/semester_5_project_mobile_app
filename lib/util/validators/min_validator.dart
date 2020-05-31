import 'package:semester_5_project_mobile_app/util/validators/base_validator.dart';

class MinValidator extends BaseValidator {
  final int length;
  MinValidator(this.length) : super('min $length characters');

  @override
  validate() {
    return this.input.length >= length;
  }
}
