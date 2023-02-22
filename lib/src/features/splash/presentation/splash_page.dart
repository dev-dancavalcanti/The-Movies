import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_movies/src/shared/routes/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      Modular.to.navigate('/${Routes.auth}${Routes.authSignIn}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
    );
  }
}
