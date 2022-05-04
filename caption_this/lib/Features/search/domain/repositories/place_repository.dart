//place repository

import 'package:caption_this/core/network/api_base_helper.dart';
import 'dart:io';
import '../../../read_dummy_data/read-dummy_data.dart';
import '../entities/place_info.dart';

class PlaceRepository {
  Future<String> place(String id, String name, String description,
      double latitude, double longitude, createdBy) async {
    //http request to get place info

    //ApiBaseHelper helper = ApiBaseHelper();

    return getJson("place.json");

    // var res = await helper.get("/place");
    // print(res);
    // return res;
  }

  Future<List<PlaceInfo>> getPlacesResumed() async {
    ApiBaseHelper helper = ApiBaseHelper();
    var res = await helper.get("/place/resumed");

    List<PlaceInfo> places =
        res.map<PlaceInfo>((e) => PlaceInfo.fromJson(e)).toList();
    return places;
  }
}
