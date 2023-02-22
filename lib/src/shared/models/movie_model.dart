class Movies {
  List<Movie>? movies;

  Movies({this.movies});

  Movies.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      movies = <Movie>[];
      json['results'].forEach((v) {
        movies!.add(Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (movies != null) {
      data['results'] = movies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Movie {
  String? posterPath;
  String? overview;
  String? releaseDate;
  List<int>? genreIds;
  int? id;
  String? title;
  String? backdropPath;
  num? popularity;
  num? voteAverage;

  Movie({
    this.posterPath,
    this.overview,
    this.releaseDate,
    this.genreIds,
    this.id,
    this.title,
    this.backdropPath,
    this.popularity,
    this.voteAverage,
  });

  List<String> listGenre = [];

  List<String> getGenrer(List<int> genreIds) {
    List<String> genreList = [];

    for (var i = 0; i < genreIds.length; i++) {
      var result = getGenresMovies(genreIds[i]);
      genreList.add(result);
    }
    return listGenre = genreList;
  }

  Movie.fromJson(Map<String, dynamic> json) {
    posterPath = json['poster_path'] != null
        ? 'https://image.tmdb.org/t/p/w500/${json['poster_path']}'
        : backdropPath ??
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png';
    overview = json['overview'].toString().isEmpty
        ? 'Desculpa nao temos sinopse desse filme'
        : json['overview'];
    releaseDate = json['release_date'] ?? '';
    genreIds = getGenrer(json['genre_ids'].cast<int>()).cast<int>();
    id = json['id'];
    title = json['title'] ?? '';
    backdropPath = json['backdrop_path'] != null
        ? 'https://image.tmdb.org/t/p/w500/${json['backdrop_path']}'
        : posterPath ??
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png';
    popularity = json['popularity'];
    voteAverage = json['vote_average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['poster_path'] = posterPath;
    data['overview'] = overview;
    data['release_date'] = releaseDate;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['title'] = title;
    data['backdrop_path'] = backdropPath;
    data['popularity'] = popularity;
    data['vote_average'] = voteAverage;

    return data;
  }
}

String getGenresMovies(int index) {
  switch (index) {
    case 28:
      return 'Ação';
    case 12:
      return 'Aventura';
    case 16:
      return 'Animação';
    case 35:
      return 'Comédia';
    case 80:
      return 'Crime';
    case 99:
      return 'Doc';
    case 18:
      return 'Drama';
    case 10751:
      return 'Família';
    case 14:
      return 'Fantasia';
    case 36:
      return 'Historia';
    case 27:
      return 'Terror';
    case 10402:
      return 'Música';
    case 9648:
      return 'Mistério';
    case 10749:
      return 'Romance';
    case 878:
      return 'Ficção';
    case 10770:
      return 'TV';
    case 53:
      return 'Suspense';
    case 10752:
      return 'Guerra';
    case 37:
      return 'Faroeste';

    default:
      '';
      return '';
  }
}
