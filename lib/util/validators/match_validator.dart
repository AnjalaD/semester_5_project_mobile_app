import 'package:semester_5_project_mobile_app/util/validators/base_validator.dart';

class MatchVatidator extends BaseValidator {
  String checkWith;
  final String label;
  MatchVatidator({this.checkWith, this.label})
      : super("Dose not match with $label");

  @override
  validate() {
    return checkWith == this.input;
  }
}
