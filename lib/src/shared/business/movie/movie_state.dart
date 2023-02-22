import 'package:equatable/equatable.dart';
import 'package:the_movies/src/shared/models/movie_model.dart';

abstract class MovieState extends Equatable {}

class MovieLoadingState extends MovieState {
  @override
  List<Object?> get props => [];
}

class MovieLoadedState extends MovieState {
  @override
  List<Object?> get props => [];
}

class MovieFailureState extends MovieState {
  final String errorMessage;
  MovieFailureState({this.errorMessage = ''});

  @override
  List<Object?> get props => [errorMessage];
}

class MovieInitState extends MovieState {
  @override
  List<Object?> get props => [];
}
