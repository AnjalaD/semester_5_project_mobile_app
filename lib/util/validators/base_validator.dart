abstract class BaseValidator {
  String _error;
  String _input;

  String get error => _error;
  String get input => _input;

  BaseValidator(this._error);

  void setInput(String input) {
    this._input = input;
  }

  validate();
}
