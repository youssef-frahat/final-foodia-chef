import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodia_chef/core/app_config/constants.dart';
import 'package:foodia_chef/core/app_config/prefs_keys.dart';
import 'package:foodia_chef/core/helpers/secure_local_storage.dart';
import 'package:http/http.dart' as http;

class Control extends ChangeNotifier {
  var chefs;
  String ip = "https://mangamediaa.com/house-food/public";

  var noti;
  Noti() async {
    String? token = await SecureLocalStorage.read(PrefsKeys.token);
    noti = null;
    final storage = FlutterSecureStorage();
    // String? token = await storage.read(key: AppConstants.token);

    noti = null;
    String url = "$ip/api/chef/notifications";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', //
          "lang": "en",
        },
      );
      if (response.body.isNotEmpty) {
        //response.statusCode == 200 &&
        var responsebody = jsonDecode(response.body);
        noti = responsebody;
        print(responsebody.length);
        print(responsebody.length);
        print(responsebody);
        print(responsebody);
      } else {
        noti = {'status': false, 'data': []};
      }
    } catch (e) {
      print(e);
    }
    print("noti");
    notifyListeners();
  }

  var readnoti;
  ReadNoti(int id) async {
    readnoti = null;
    final storage = FlutterSecureStorage();
    // String? token = await storage.read(key: AppConstants.token);

    String? token = await SecureLocalStorage.read(PrefsKeys.token);

    readnoti = null;
    String url = "$ip/api/chef/notifications/$id";
    try {
      var response = await http.put(
        Uri.parse(url),
        // body: {"_method": "PUT"},
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', //
          "lang": "en",
        },
      );
      if (response.body.isNotEmpty) {
        //response.statusCode == 200 &&
        var responsebody = jsonDecode(response.body);
        readnoti = responsebody;
        print(responsebody.length);
        print(responsebody.length);
        print(responsebody);
        print(responsebody);
        Noti();
        NotiCont();
      } else {
        readnoti = {'status': false, 'data': []};
      }
    } catch (e) {
      print(e);
    }
    print("readnoti");
    notifyListeners();
  }

  var noticont;
  NotiCont() async {
    String? token = await SecureLocalStorage.read(PrefsKeys.token);
    noticont = null;
    final storage = FlutterSecureStorage();
    // String? token = await storage.read(key: AppConstants.token);

    noticont = null;
    String url = "$ip/api/chef/count";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', //
          "lang": "en",
        },
      );
      if (response.body.isNotEmpty) {
        //response.statusCode == 200 &&
        var responsebody = jsonDecode(response.body);
        noticont = responsebody;
        print(responsebody.length);
        print(responsebody.length);
        print(responsebody);
        print(responsebody);
      } else {
        noticont = {'status': false, 'data': []};
      }
    } catch (e) {
      print(e);
    }
    print("noticont");
    notifyListeners();
  }
}
//  Consumer<Control>(builder: (context, val, child) {
//       return
