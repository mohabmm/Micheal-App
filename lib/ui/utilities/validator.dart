import 'package:meta/meta.dart' as Meta;

enum Validator { Required, Email }

class ValidationMessages {
  Map<Validator, String> messages = {
    Validator.Required: ':attribute is Required',
    Validator.Email: ':attribute must be a valid Email'
  };

  get(attribute, Validator validator) {
    return messages[validator].replaceAll(':attribute', attribute);
  }
}

class Validators {
  final String name;
  final String value;
  final ValidationMessages messages = ValidationMessages();

  Validators({@Meta.required this.name, @Meta.required this.value});

  static Validator required(String value) {
    if (value.isEmpty) {
      return Validator.Required;
    }
    return null;
  }

  static Validator email(String value) {
    RegExp regExp = RegExp(r"(.+)@(.+)\.(.+)");
    return regExp.hasMatch(value) ? null : Validator.Email;
  }

  String compose(dynamic validators) {
    if (validators is! List) {
      Validator valid = validators(this.value);
      if (valid != null) return messages.get(name, valid);
    } else {
      for (Validator Function(String value) validator in validators) {
        Validator valid = validator(this.value);
        if (valid != null) return messages.get(name, valid);
        continue;
      }
    }
    return null;
  }
}
