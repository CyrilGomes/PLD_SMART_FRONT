import 'dart:io';
String getJson(String file)=> File("caption_this/lib/Features/read_dummy_data/dummy_data/$file").readAsStringSync() ;