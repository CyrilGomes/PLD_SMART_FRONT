class PlaceInfo {
  int id = -1;
  String? description = "for testing purposes"; //length=1000
  String? name = "Hell-219";
  //String image="";
  double latitude = 0.0;
  double longitude = 0.0;
  String? createdBy = "4mina";
  bool visited = false;

  PlaceInfo(
      {required int id,
      required String name,
      required String description,
      required double latitude,
      required double longitude,
      required createdBy,
      required visited}) {
    id = id;
    name = name;
    description = description;
    latitude = latitude;
    longitude = longitude;
    createdBy = createdBy;
    visited = visited;
  }

  @override
  bool operator ==(Object other) => other is PlaceInfo && id == other.id;

  PlaceInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdBy = json['created_by'];
    visited = json['visited'] ?? false;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
      };
}
