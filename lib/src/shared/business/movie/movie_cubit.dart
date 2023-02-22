import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_movies/src/shared/business/movie/movie_state.dart';
import 'package:the_movies/src/shared/exceptions/http_exception.dart';
import 'package:the_movies/src/shared/models/movie_model.dart';
import 'package:the_movies/src/shared/repositories/movie/movie_repositories.dart';

class MovieCubit extends Cubit<MovieState> {
  late MovieRepository _movieRepository;
  MovieCubit() : super(MovieInitState()) {
    _initialize();
  }

  int page = 1;

  Future<void> _initialize() async {
    _movieRepository = Modular.get<MovieRepository>();
    await getPopularMovies();
    await getTopRatedMovies();
    await getUpCommingMovies();
  }

  List<Movie>? popularMovies;
  List<Movie>? topRatedMovies;
  List<Movie>? upCommingMovies;

  Future<void> getPopularMovies() async {
    emit(MovieLoadingState());
    int page = 1;
    _movieRepository.getMostPopularMovies(page)
      ..then((val) {
        if (state is! MovieFailureState) {
          popularMovies = val;
          emit(MovieLoadedState());
        }
      })
      ..catchError((error, stackTrace) async {
        String errorMessage = 'Erro inesperado. Tente novamente mais tarde.';
        if (error is HttpException) errorMessage = error.message;
        emit(MovieFailureState(errorMessage: errorMessage));
        return error;
      });
  }

  Future<void> getTopRatedMovies() async {
    int page = 1;
    _movieRepository.getTopRatedMovies(page)
      ..then((val) {
        if (state is! MovieFailureState) {
          topRatedMovies = val;
          emit(MovieLoadedState());
        }
      })
      ..catchError((error, stackTrace) async {
        String errorMessage = 'Erro inesperado. Tente novamente mais tarde.';
        if (error is HttpException) errorMessage = error.message;
        emit(MovieFailureState(errorMessage: errorMessage));
        return error;
      });
  }

  Future<void> getUpCommingMovies() async {
    int page = 1;
    _movieRepository.getUpCommingMovies(page)
      ..then((val) {
        if (state is! MovieFailureState) {
          upCommingMovies = val;
          emit(MovieLoadedState());
        }
      })
      ..catchError((error, stackTrace) async {
        String errorMessage = 'Erro inesperado. Tente novamente mais tarde.';
        if (error is HttpException) errorMessage = error.message;
        emit(MovieFailureState(errorMessage: errorMessage));
        return error;
      });
  }
}
