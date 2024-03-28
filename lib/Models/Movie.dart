class Movie {
  late int id;
  late String title;
  late double voteAverage;
  late String overview;
  late String posterPath;

  Movie(this.id, this.title, this.voteAverage, this.overview, this.posterPath);

  Movie.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    title = parsedJson['title'] ?? ''; // Handle null by providing a default value (empty string)
    voteAverage = parsedJson['vote_average'] ?? 0.0; // Handle null by providing a default value (0.0)
    overview = parsedJson['overview'] ?? ''; // Handle null by providing a default value (empty string)
    posterPath = parsedJson['poster_path'] ?? ''; // Handle null by providing a default value (empty string)
  }
}
