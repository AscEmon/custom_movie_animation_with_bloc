import 'package:custom_movie_animation/modules/movie_list/repository/movies_interface.dart';
import 'package:custom_movie_animation/modules/movie_list/repository/movies_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/enum.dart';
import '../model/movies_response.dart';
import 'movie_list_event.dart';
import 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final IMoviesRepository _iMoviesRepository = MoviesRepository();
  MovieListBloc() : super(const MovieListState()) {
    on<LoadMovies>(_fetchMovies);
    on<BackgroundChanged>(_backgroundChanedBasedonIndex);
  }

  void _backgroundChanedBasedonIndex(
      BackgroundChanged event, Emitter<MovieListState> emit) {
    emit(state.copyWith(index: event.index));
  }

  void _fetchMovies(MovieListEvent event, Emitter<MovieListState> emit) async {
    try {
      List<MoviesResponse> result = await _iMoviesRepository.fetchMovies();

      emit(
        state.copyWith(
          fetchMovieStatus: AppStatus.success,
          movies: result,
        ),
      );
    } catch (error) {
      emit(state.copyWith(fetchMovieStatus: AppStatus.error));
    }
  }
}
