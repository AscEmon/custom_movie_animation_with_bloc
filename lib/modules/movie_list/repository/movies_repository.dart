import 'dart:async';

import 'package:custom_movie_animation/utils/extension.dart';

import '../../../constant/app_url.dart';
import '../../../utils/enum.dart';
import '../../../utils/network_request_builder.dart';
import '../model/movies_response.dart';
import 'movies_interface.dart';

class MoviesRepository implements IMoviesRepository {
  @override
  Future<List<MoviesResponse>> fetchMovies() async {
    Completer<List<MoviesResponse>> completer =
        Completer<List<MoviesResponse>>();

    try {
      NetworkRequestBuilder()
          .setUrl(AppUrl.moviesUrl.url)
          .setMethod(Method.GET)
          .setOnSuccess((response) async {
        final movies = moviesResponseFromJson(response.data);
        if (movies.isNotEmpty) {
          completer.complete(movies);
        } else {
          completer.complete([]);
        }
      }).setOnFailed((errorMessage) {
        completer.completeError(errorMessage);
      }).executeNetworkRequest();
    } catch (e) {
      "$e".log();
    }

    return completer.future;
  }
}
