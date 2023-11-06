import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netwin_test/globals/constants.dart';
import 'package:netwin_test/models/get_users_response.dart';

Future<GetUsersResponse> getUsers() async {
  var response = await http.get(Uri.parse("${baseUrl}users/"));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return GetUsersResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
