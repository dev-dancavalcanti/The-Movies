import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_movies/src/shared/business/auth/auth_cubit.dart';

class AuthSignUpPage extends StatelessWidget {
  const AuthSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = Modular.get<AuthCubit>();

    TextEditingController email = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController dateBirthday = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          controller: name,
        ),
        TextFormField(
          controller: email,
        ),
        TextFormField(
          controller: password,
        ),
        TextFormField(
          controller: dateBirthday,
        ),
        ElevatedButton(
            onPressed: () {
              cubit.signUp(
                  name: name.text,
                  email: email.text,
                  password: password.text,
                  dateBirthday: dateBirthday.text);
            },
            child: const Text('Registrar'))
      ],
    );
  }
}
