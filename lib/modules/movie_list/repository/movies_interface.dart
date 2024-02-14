import 'package:flutter/material.dart';
import '../model/movies_response.dart';

@immutable
abstract class IMoviesRepository {
  Future<List<MoviesResponse>> fetchMovies();
}
