//place repository

import 'package:caption_this/core/network/api_base_helper.dart';

import '../entities/place_info.dart';

class PlaceRepository {
  Future<String> place(String id, String name,String description,double latitude,double longitude,createdBy ) async {
    //http request to get place info

    ApiBaseHelper helper = ApiBaseHelper();

    var res = await helper.get("/place");
    print(res);
     return res;
  }

}
