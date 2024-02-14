import 'dart:convert';

List<MoviesResponse> moviesResponseFromJson(List<dynamic> jsonData) =>
    jsonData.map((item) => MoviesResponse.fromJson(item)).toList();

String moviesResponseToJson(List<MoviesResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MoviesResponse {
  int? id;
  String? movie;
  double? rating;
  String? image;
  String? imdbUrl;

  MoviesResponse({
    this.id,
    this.movie,
    this.rating,
    this.image,
    this.imdbUrl,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) => MoviesResponse(
        id: int.tryParse(json["id"].toString()),
        movie: json["movie"],
        rating: json["rating"]?.toDouble(),
        image: json["image"],
        imdbUrl: json["imdb_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "movie": movie,
        "rating": rating,
        "image": image,
        "imdb_url": imdbUrl,
      };
}
