List<RecommendPlace> getRecommendPlacesList(List<dynamic> str) =>
    List<RecommendPlace>.from(str.map((x) => RecommendPlace.fromJson(x)));

class RecommendPlace {
  String type;
  Details details;

  RecommendPlace({
    required this.type,
    required this.details,
  });

  factory RecommendPlace.fromJson(Map<String, dynamic> json) => RecommendPlace(
        type: json["type"],
        details: Details.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "details": details.toJson(),
      };
}

class Details {
  String name;
  String theLocation;
  String image;

  Details({
    required this.name,
    required this.theLocation,
    required this.image,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        name: json["name"],
        theLocation: json["the_location"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "the_location": theLocation,
        "image": image,
      };
}
