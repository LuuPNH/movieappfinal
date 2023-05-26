class Movie {
  final int? id;
  final double? popularity;
  final String? title;
  final String? backPoster;
  final String? poster;
  final String? overview;
  final double? rating;

  Movie(this.id, this.popularity, this.title, this.backPoster, this.poster,
      this.overview, this.rating);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"],
        title = json["title"],
        backPoster = json["backdrop_path"],
        poster = json["poster_path"],
        overview = json["overview"],
        rating = json["vote_average"].toDouble();

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'popularity': this.popularity,
      'title': this.title,
      'backPoster': this.backPoster,
      'poster': this.poster,
      'overview': this.overview,
      'rating': this.rating,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      map['id'] as int,
      map['popularity'] as double,
      map['title'] as String,
      map['backPoster'] as String,
      map['poster'] as String,
      map['overview'] as String,
      map['rating'] as double,
    );
  }
}
