List<Place> getPlacesList(List<dynamic> str) =>
    List<Place>.from(str.map((x) => Place.fromJson(x)));

class Place {
  String name;
  String governorate;
  String latitude;
  String longitude;
  String theLocation;
  double averageRating;
  String workingHours;
  int numberOfVisits;
  bool active;
  List<String> images;

  Place({
    required this.name,
    required this.governorate,
    required this.latitude,
    required this.longitude,
    required this.theLocation,
    required this.averageRating,
    required this.workingHours,
    required this.numberOfVisits,
    required this.active,
    required this.images,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        name: json["name"],
        governorate: json["governorate"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        theLocation: json["the_location"],
        averageRating: json["average_rating"],
        workingHours: json["working_hours"],
        numberOfVisits: json["number_of_visits"],
        active: json["active"],
        images: List<String>.from(json["images"].map((x) => x['image'])),
      );
}
