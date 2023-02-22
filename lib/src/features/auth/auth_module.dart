import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_movies/src/features/auth/presentation/auth_page.dart';
import 'package:the_movies/src/features/auth/presentation/auth_sign_in_page.dart';
import 'package:the_movies/src/features/auth/presentation/auth_sign_up_page.dart';
import 'package:the_movies/src/shared/routes/routes.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const AuthPage(),
          children: [
            ChildRoute(
              '/${Routes.authSignIn}',
              child: (context, args) => const AuthSignInPage(),
              transition: TransitionType.fadeIn,
            ),
            ChildRoute(
              '/${Routes.authSignUp}',
              child: (context, args) => const AuthSignUpPage(),
              transition: TransitionType.fadeIn,
            ),
          ],
        ),
      ];
}
