class PredictedRestaurants {
  String foodCategory;
  List<Restaurant> restaurants;

  PredictedRestaurants({
    required this.foodCategory,
    required this.restaurants,
  });

  factory PredictedRestaurants.fromJson(Map<String, dynamic> json) =>
      PredictedRestaurants(
        foodCategory: json["food_category"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "food_category": foodCategory,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class Restaurant {
  String name;
  List<String> images;
  String detailsUrl;

  Restaurant({
    required this.name,
    required this.images,
    required this.detailsUrl,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        name: json["name"],
        images: List<String>.from(json["images"].map((x) => x)),
        detailsUrl: json["details_url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "images": List<dynamic>.from(images.map((x) => x)),
        "details_url": detailsUrl,
      };
}
