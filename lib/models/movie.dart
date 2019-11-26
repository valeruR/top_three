class Movie {
  final int movieId;
  final String title;
  final String body;

  Movie({ this.movieId, this.title, this.body });

  factory Movie.fromJson(Map<String, dynamic> json) {
    print(json);
    return Movie(
      movieId: json['id'],
      title: json['title'],
      body: json['overview'],
    );
  }
}