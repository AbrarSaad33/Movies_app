import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkManager {
  String uri = '';

  requestHttp(response) async {
    final result = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return result;
    } else if (response.statusCode >= 300 && response.statusCode <= 399) {
      print("${response.statusCode} redirection");
      return result;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      print("${response.statusCode} Bad Request ");
      return result;
    } else {
      print(response);
      print(
          '${response.statusCode}Error occured while Communication with Server with StatusCode ');
    }
  }

  Future get(uri) async {
    final response = await http.get(Uri.parse(uri));
    return requestHttp(response);
  }

  Future post(uri, body) async {
    final response = await http.post(Uri.parse(uri), body: body);
    return requestHttp(response);
  }
}
