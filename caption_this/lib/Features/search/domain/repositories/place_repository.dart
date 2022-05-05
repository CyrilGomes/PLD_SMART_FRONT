//place repository

import 'dart:convert';

import 'package:caption_this/core/network/api_base_helper.dart';

import '../../../read_dummy_data/read-dummy_data.dart';
import '../entities/place_info.dart';

class PlaceRepository {

  Future<PlaceInfo> place(String id) async {

    //http request to get place info

    ApiBaseHelper helper = ApiBaseHelper();
    var res= await helper.get("/place/$id");
    if( res== null){ throw Exception("error fetching place info");

    }
    PlaceInfo placeInfo= PlaceInfo.fromJson(jsonDecode(res));
    return placeInfo;




    // var res = await helper.get("/place/resumed/$id");
    // print(res);
    // return res;
    // if (res == null) throw Exception("error fetching place info");
    // return res != null;
  }

  Future<List<PlaceInfo>> getPlacesResumed() async {
    ApiBaseHelper helper = ApiBaseHelper();
    var res = await helper.get("/place/resumed");

    List<PlaceInfo> places =
        res.map<PlaceInfo>((e) => PlaceInfo.fromJson(e)).toList();
    return places;
  }
}
