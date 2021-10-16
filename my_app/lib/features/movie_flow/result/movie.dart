import 'package:flutter/foundation.dart';

import 'package:movie_recommendation_app_course/features/movie_flow/genre/genre.dart';
import 'package:movie_recommendation_app_course/features/movie_flow/result/movie_entity.dart';

@immutable
class Movie {
  final String title;
  final String overview;
  final num voteAverage;
  final List<Genre> genres;
  final List<Movie> similarMovies;
  final String releaseDate;
  final String? backdropPath;
  final String? posterPath;

  const Movie({
    required this.title,
    required this.overview,
    required this.voteAverage,
    required this.genres,
    required this.similarMovies,
    required this.releaseDate,
    this.backdropPath,
    this.posterPath,
  });

  factory Movie.fromEntity(
      MovieEntity entity, List<Genre> genres, List<Movie> similarMovies) {
    return Movie(
      title: entity.title,
      overview: entity.overview,
      voteAverage: entity.voteAverage,
      genres: genres
          .where((genre) => entity.genreIds.contains(genre.id))
          .toList(growable: false),
      similarMovies: similarMovies,
      releaseDate: entity.releaseDate,
      backdropPath:
          'https://image.tmdb.org/t/p/original/${entity.backdropPath}',
      posterPath: 'https://image.tmdb.org/t/p/original/${entity.posterPath}',
    );
  }

  Movie.initial()
      : title = '',
        overview = '',
        voteAverage = 0,
        genres = [],
        similarMovies = [],
        releaseDate = '',
        backdropPath = '',
        posterPath = '';

  String get genresCommaSeparated =>
      genres.map((e) => e.name).toList().join(', ');

  @override
  String toString() {
    return 'Movie(title: $title, overview: $overview, voteAverage: $voteAverage, genres: $genres, releaseDate: $releaseDate, backdropPath: $backdropPath, posterPath: $posterPath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movie &&
        other.title == title &&
        other.overview == overview &&
        other.voteAverage == voteAverage &&
        listEquals(other.genres, genres) &&
        listEquals(other.similarMovies, similarMovies) &&
        other.releaseDate == releaseDate;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        overview.hashCode ^
        voteAverage.hashCode ^
        genres.hashCode ^
        similarMovies.hashCode ^
        releaseDate.hashCode;
  }
}
