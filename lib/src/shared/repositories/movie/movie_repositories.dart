import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_movies/src/shared/models/movie_model.dart';
import 'package:the_movies/src/shared/services/http/http_service.dart';

class MovieRepository {
  late HttpService _httpClient;
  MovieRepository() {
    initialize();
  }

  String upCommingPath = 'movie/upcoming?page=';
  String mostPopularPath = 'movie/popular?page=';
  String topRatedPath = 'movie/top_rated?page=';

  Future<void> initialize() async {
    _httpClient = Modular.get<HttpService>();
  }

  Future<List<Movie>?> getTopRatedMovies(int page) async {
    var response = await _httpClient.get('$topRatedPath$page');
    return Movies.fromJson(response.data).movies;
  }

  Future<List<Movie>?> getMostPopularMovies(int page) async {
    var response = await _httpClient.get('$mostPopularPath$page');
    return Movies.fromJson(response.data).movies;
  }

  Future<List<Movie>?> getUpCommingMovies(int page) async {
    var response = await _httpClient.get('$upCommingPath$page');
    return Movies.fromJson(response.data).movies;
  }

  Future<List<Movie>?> getSearchMovies(String search, int page) async {
    var response =
        await _httpClient.get('search/movie?&query=$search&page=$page&include_adult=false');
    return Movies.fromJson(response.data).movies;
  }
}
