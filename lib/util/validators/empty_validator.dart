import 'package:semester_5_project_mobile_app/util/validators/base_validator.dart';

class EmptyValidator extends BaseValidator {
  EmptyValidator() : super('Cannot be empty');

  @override
  validate() {
    return this.input.isNotEmpty;
  }
}
