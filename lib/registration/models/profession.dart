import 'package:formz/formz.dart';

enum ProfessionValidationError { empty }

class Profession extends FormzInput<String, ProfessionValidationError> {
  const Profession.pure() : super.pure('');
  const Profession.dirty([String value = '']) : super.dirty(value);

  @override
  ProfessionValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : ProfessionValidationError.empty;
  }
}
