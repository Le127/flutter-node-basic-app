import 'package:users_app_client/helpers/platform_details.dart';
import 'package:users_app_client/models/users.dart';
import 'package:http/http.dart' as http;

class ServerApi {

  static String baseUrl = '';
  static String baseUrlplatform() {
    if (PlatformDetails().isDesktop) {
      return baseUrl = 'http://localhost:4000/api';
    } else {
      return baseUrl = 'http://10.0.2.2:4000/api';
    }
  }

  //GetAllUsers
  static Future<Users> getUsers(String path) async {
    try {
      var urlParse = Uri.parse(baseUrl + path);
      http.Response response = await http.get(urlParse);
      final users = usersFromJson(response.body);
      return users;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      throw ("Error en el GET");
    }
  }

  //DeleteAllUsers
  static Future deleteUsers(String path) async {
    try {
      var urlParse = Uri.parse(baseUrl + path);
      http.Response response = await http.delete(urlParse);

      return response;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      throw ("Error en el GET");
    }
  }





    //CreateAllUsers
  static Future createUser(String path) async {
    try {
      var urlParse = Uri.parse(baseUrl + path);
      http.Response response = await http.post(urlParse);

      return response;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      throw ("Error en el GET");
    }
  }
}
