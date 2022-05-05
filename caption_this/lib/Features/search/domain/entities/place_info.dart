class PlaceInfo {
  String id = "";
  String description = "for testing purposes"; //length=1000
  String name = "Hell-219";
  //String image="";
  double latitude=0.0;
  double longitude=0.0;
  String createdBy="4mina";

  PlaceInfo({required String id, required String name, required String description,required double latitude,required double longitude,required createdBy}) {
    id = id;
    name = name;
    description = description;
    latitude=latitude;
    longitude=longitude;
    createdBy=createdBy;
  }

  PlaceInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    latitude=json['latitude'];
    longitude=json['longitude'];
    createdBy=json['created_by'];
  }
  Map<String, dynamic> toJson(){
    return{
    'id' : id,
    'name' : name,
    'description' : description,
    'latitude':latitude,
    'longitude':longitude,
    'createdBy':createdBy,
    };
  }
}