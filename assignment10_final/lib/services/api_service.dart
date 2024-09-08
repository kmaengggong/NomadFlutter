import 'package:assignment10_final/models/movie_detail_model.dart';
import 'package:assignment10_final/models/movie_model.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String popular = "popular";
  static const String now = "now-playing";
  static const String soon = "coming-soon";

  static Future<List<MovieModel>> getPopularMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/$popular');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body)['results'];
      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie);
        movieInstances.add(instance);
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getNowMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/$now');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body)['results'];
      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie);
        movieInstances.add(instance);
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getSoonMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/$soon');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body)['results'];
      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie);
        movieInstances.add(instance);
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getMovieDetail(String id) async {
    final url = Uri.parse('$baseUrl/movie?id=$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movie = jsonDecode(response.body);
      final instance = MovieDetailModel.fromJson(movie);
      return instance;
    }
    throw Error();
  }
}
