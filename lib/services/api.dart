import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:Mobile_Test/data/models/users.dart';
import 'package:path_provider/path_provider.dart';

Future<List<Data>> getUserInfo() async {
  //cache data method
  String fileName = "userData.json";

  var dir = await getTemporaryDirectory();

  File file = File(dir.path + "/" + fileName);

  if (file.existsSync()) {
    print("Loading From cache");
    var data = file.readAsStringSync(); //read from cache
    final jsonData = jsonDecode(data);

    List<Data> userInfo = [];
    Iterable<dynamic> list = jsonData["data"];
    userInfo = list.map((items) => Data.fromJson(items)).toList();
    return userInfo;
  } else {
//api call
    print("Loading From Api");
    final String apiUrl = 'https://reqres.in/api/users';
    var data = await http.get(apiUrl, headers: {"Accept": "application/json"});

    if (data.statusCode == 200) {
      var response = data.body;
      var jsonData = jsonDecode(response);
      file.writeAsStringSync(response, //save to cache
          flush: true,
          mode: FileMode.write);
      List<Data> userInfo = [];
      Iterable<dynamic> list = jsonData["data"];
      userInfo = list.map((items) => Data.fromJson(items)).toList();
      return userInfo;
    } else {
      throw Exception('Failed to Load UserInfo');
    }
  }
}
