import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_movies/src/shared/business/auth/auth_cubit.dart';
import 'package:the_movies/src/shared/business/auth/auth_state.dart';
import 'package:the_movies/src/shared/routes/routes.dart';

class AuthSignInPage extends StatefulWidget {
  const AuthSignInPage({super.key});

  @override
  State<AuthSignInPage> createState() => _AuthSignInPageState();
}

class _AuthSignInPageState extends State<AuthSignInPage> {
  final cubit = Modular.get<AuthCubit>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool verifyUser = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: cubit,
      listener: (context, state) {
        if (state is AuthSucessState) {
          verifyUser = true;
        } else {
          verifyUser = false;
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              verifyUser
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.transparent.withOpacity(.6),
                          child: cubit.userLogged!.picture.isEmpty
                              ? const Icon(Icons.person)
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image.network(
                                    cubit.userLogged!.picture,
                                    fit: BoxFit.fill,
                                  )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(
                            cubit.userLogged!.name,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(cubit.userLogged!.email,
                              style: const TextStyle(fontWeight: FontWeight.w500)),
                        ]),
                        Column(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  cubit.userNull();
                                },
                                child: const Icon(Icons.remove))
                          ],
                        )
                      ],
                    )
                  : TextFormField(
                      controller: email,
                    ),
              TextFormField(
                onTap: () {
                  cubit.verifyUser(email: email.text);
                },
                obscureText: true,
                controller: password,
              ),
              ElevatedButton(
                  onPressed: () {
                    cubit.signIn(email: email.text, password: password.text);
                  },
                  child: const Text('Login')),
              TextButton(
                  onPressed: () {
                    Modular.to.navigate('/${Routes.auth}${Routes.authSignUp}');
                  },
                  child: const Text('Nao tem cadastro ?'))
            ],
          ),
        );
      },
    );
  }
}
