extension ValidateExtension on String {
  String? validateEmail() {
    final regexEmail =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (!regexEmail.hasMatch(this)) return 'E-mail inválido';

    return null;
  }

  String? validatePassword() {
    if (isEmpty) {
      return 'Campo obrigatório';
    } else if (length < 6) {
      return "A senha precisa ter mais de 6 dígitos";
    }
    return null;
  }

  String? validateCpf() {
    final regex = RegExp(
        r"^([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})");
    if (!regex.hasMatch(this)) return 'CPF inválido';

    return null;
  }

  bool isOnlyNumbers() {
    final regex = RegExp(r"^-?(([0-9]*)|(([0-9]*)\,([0-9]*))|(([0-9]*)\.([0-9]*)))$");
    return regex.hasMatch(this);
  }
}
