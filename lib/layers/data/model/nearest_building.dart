import 'package:encrypt/encrypt.dart' as encrypt;

class NearestBuilding {
  Building building;

  NearestBuilding({
    required this.building,
  });

  factory NearestBuilding.fromJson(Map<String, dynamic> json) =>
      NearestBuilding(
        building: Building.fromJson(json["building"]),
      );

  Map<String, dynamic> toJson() => {
        "building": building.toJson(),
      };
}

class Building {
  double latitude;
  double longitude;
  int buildingId;
  String buildingName;

  Building({
    required this.latitude,
    required this.longitude,
    required this.buildingId,
    required this.buildingName,
  });

  factory Building.fromJson(Map<String, dynamic> json) => Building(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        buildingId: json["building_id"],
        buildingName: json["building_name"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "building_id": buildingId,
        "building_name": buildingName,
      };
}
