import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_movies/src/features/auth/auth_module.dart';
import 'package:the_movies/src/features/movies/movies_module.dart';
import 'package:the_movies/src/features/splash/splash_module.dart';
import 'package:the_movies/src/shared/business/auth/auth_cubit.dart';
import 'package:the_movies/src/shared/business/movie/movie_cubit.dart';
import 'package:the_movies/src/shared/repositories/auth/auth_repositories.dart';
import 'package:the_movies/src/shared/repositories/movie/movie_repositories.dart';
import 'package:the_movies/src/shared/routes/routes.dart';
import 'package:the_movies/src/shared/services/firebase/firebase_service_imp.dart';
import 'package:the_movies/src/shared/services/http/http_service_dio.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => FirebaseServiceImp()),
        Bind.singleton((i) => HttpServiceDio()),
        Bind.singleton((i) => AuthCubit()),
        Bind.singleton((i) => AuthRepository()),
        Bind.singleton((i) => MovieCubit()),
        Bind.singleton((i) => MovieRepository()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: SplashModule()),
        ModuleRoute('/${Routes.auth}', module: AuthModule()),
        ModuleRoute('/${Routes.movies}', module: MoviesModule()),
      ];
}
