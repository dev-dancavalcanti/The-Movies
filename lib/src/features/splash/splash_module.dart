import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_movies/src/features/splash/presentation/splash_page.dart';

class SplashModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const SplashPage(),
        ),
      ];
}
