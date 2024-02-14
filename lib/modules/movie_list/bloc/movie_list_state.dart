import 'package:custom_movie_animation/utils/enum.dart';
import 'package:flutter/material.dart';

import '../model/movies_response.dart';

@immutable
class MovieListState {
  final int index;
  final List<MoviesResponse>? movies;
  final AppStatus fetchMovieStatus;
  const MovieListState({
    this.index = 0,
    this.movies,
    this.fetchMovieStatus = AppStatus.loading,
  });

  MovieListState copyWith({
    int? index,
    List<MoviesResponse>? movies,
    AppStatus? fetchMovieStatus,
  }) {
    return MovieListState(
      index: index ?? this.index,
      movies: movies ?? this.movies,
      fetchMovieStatus: fetchMovieStatus ?? this.fetchMovieStatus,
    );
  }
}
