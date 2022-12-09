import 'dart:convert';

import 'package:http/http.dart';

class BaseClient {
  var client = Client();
  Future<dynamic> getLocationData(String url) async {
    Uri urli = Uri.parse(url);
    Response response = await get(urli);
    Map data = jsonDecode(response.body);
    return data;
  }
}
