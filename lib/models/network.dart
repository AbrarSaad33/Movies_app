import 'dart:convert';
import 'package:http/http.dart' as http;

class Network {
  String uri = '';
 
  Future get(url) async {
    final response = await http.get(url);
    
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final result = jsonDecode(response.body);

      return result;
    } else if (response.statusCode >= 300 && response.statusCode <= 399) {
      print("${response.statusCode} redirection");
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      print("${response.statusCode} Bad Request ");
    } else {
      print(response);
      throw Exception(
          '${response.statusCode}Error occured while Communication with Server with StatusCode ');
    }
  }

  post(uri, String email,String password,String name,String phone) async {
    final response = await http.post(uri,
        body: json.encode({
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
          'returnSecureToken': true
        }));

    final responseData = json.decode(response.body);
    return responseData;
  }
}
