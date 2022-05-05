//place repository

import 'package:caption_this/core/network/api_base_helper.dart';

import '../../../read_dummy_data/read-dummy_data.dart';
import '../entities/place_info.dart';

class PlaceRepository {

  Future<String> getPlaceInfo(String id) async {
    //http request to get place info

    //ApiBaseHelper helper = ApiBaseHelper();
    var res=getJson("place.json");
    return res;

    // var res = await helper.get("/place/resumed/$id");
    // print(res);
    // return res;
    // if (res == null) throw Exception("error fetching place info");
    // return res != null;
  }

}
