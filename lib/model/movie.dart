class Movie {
  String title;
  int year;
  String image;
  String release;

  Movie.toObject(Map<String, dynamic> json)
      : title = json['title'],
        year = json['year'],
        image = json['image'],
        release = json['release'];
}