class Movie {
  final int movieId;
  final String title;
  final String body;
  final String poster;

  Movie({ this.movieId, this.title, this.body, this.poster });

  factory Movie.fromJson(Map<String, dynamic> json) {
    print(json);
    return Movie(
      movieId: json['id'],
      title: json['title'],
      body: json['overview'],
    );
  }
}