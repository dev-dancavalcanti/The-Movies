import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_movies/src/features/movies/presentation/movies_page.dart';

class MoviesModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const MoviesPage(),
        ),
      ];
}
