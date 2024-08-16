List<BusStop> getBusStopList(List<dynamic> str) =>
    List<BusStop>.from(str.map((x) => BusStop.fromJson(x)));

class BusStop {
  String busName;
  int numberOfStations;
  List<String> stations;

  BusStop({
    required this.busName,
    required this.numberOfStations,
    required this.stations,
  });

  factory BusStop.fromJson(Map<String, dynamic> json) => BusStop(
        busName: json["bus_name"],
        numberOfStations: json["number_of_stations"],
        stations: List.from(json["stations"].toString().split(",")),
      );

  Map<String, dynamic> toJson() => {
        "bus_name": busName,
        "number_of_stations": numberOfStations,
        "stations": stations,
      };
}
