import 'package:assignment10_final/models/genre.dart';

class MovieDetailModel {
  final String id, title, posterPath, overview, homepage;
  final int runtime;
  final double voteAverage;
  final bool adult;
  final List<Genre> genres;

  MovieDetailModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.homepage,
    required this.runtime,
    required this.voteAverage,
    required this.adult,
    required this.genres,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    var genresJson = json['genres'] as List;
    List<Genre> genresList =
        genresJson.map((genre) => Genre.fromJson(genre)).toList();

    return MovieDetailModel(
      id: json['id'].toString(),
      title: json['title'],
      posterPath: json['poster_path'],
      adult: json['adult'],
      overview: json['overview'],
      runtime: json['runtime'],
      voteAverage: json['vote_average'],
      homepage: json['homepage'],
      genres: genresList,
    );
  }
}
