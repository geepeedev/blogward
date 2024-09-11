import 'package:formz/formz.dart';

enum CategoryValidationError { invalid }

final class Category extends FormzInput<List<String>, CategoryValidationError> {
  const Category.pure([super.value = const <String>[]]) : super.pure();
  const Category.dirty([super.value = const <String>[]]) : super.dirty();

  @override
  CategoryValidationError? validator(List<String> value) {
    return value.isEmpty ? CategoryValidationError.invalid : null;
  }
}
